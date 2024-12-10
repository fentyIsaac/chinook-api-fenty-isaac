const fs = require("fs");
const pool = require("../src/db");

const initalizeTestDatabase = async () => {
  try{
    const connection = await pool.getConnection();
    const sql = fs.readFileSync(__dirname + "/setup-test-database.sql", "utf-8");
    await connection.query(sql);
    connection.release();
  }catch(e){
    console.log(e);
  }
}


module.exports = initalizeTestDatabase