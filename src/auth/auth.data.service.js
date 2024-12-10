const pool = require("../db");
const {verifyPassword} = require("./auth.helpers")
const User = require("../users/user.model");


exports.authenticateUser = async (email, password) => {
  const connection = await pool.getConnection();
  const sql = "SELECT * FROM user WHERE UserEmail = ?";
  const [rows] = await pool.query(sql, [email]);
  
  let user = null;
  if(rows.length === 1){
    
    const hashedPassword = rows[0].UserPassword;
    const salt = rows[0].UserSalt;

    if(await verifyPassword(password, salt, hashedPassword)){
      user = new User({
        id: rows[0].UserId,
        email: rows[0].UserEmail,
        roleId: rows[0].UserRoleId,
        active: rows[0].UserActive === 1 ? true : false
      })
    }else{
      throw new Error("Invalid password");
    }
  }else{
    throw new Error("User not found: " + email);
  }
  connection.release();
  return user;
}