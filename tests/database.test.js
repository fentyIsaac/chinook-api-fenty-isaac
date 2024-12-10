const pool = require("../src/db");


describe('Database Tests', ()=>{
  it('pool.getConnection() should return truthy', async () => {
    const connection = await pool.getConnection();
    expect(connection).toBeTruthy();
    connection.release();
  });
});