const pool = require("../db");
const User = require("./user.model");

exports.getAllUsers = async () => {
  const connection = await pool.getConnection();
  const sql = "SELECT * FROM user";
  const [rows] = await connection.query(sql);
  connection.close();

  
  return rows.map(r => new User({
    id: r.UserId, 
    email: r.UserEmail, 
    roleId: r.UserRoleId, 
    active: r.UserActive ? true : false, 
    password: r.UserPassword, 
    salt: r.UserSalt
  }));
  
}

exports.getUserById = async (id) => {
  const connection = await pool.getConnection();
  const sql = "SELECT * FROM user WHERE UserId = ?";
  const [rows] = await connection.query(sql, [id]);
  let user = null;
  

  if(rows.length === 1){
    user = new User({
      id: rows[0].UserId, 
      email: rows[0].UserEmail, 
      roleId: rows[0].UserRoleId, 
      active: rows[0].UserActive, 
      password: rows[0].UserPassword, 
      salt: rows[0].UserSalt})
  }

  connection.release();
  return user;

}

exports.insertUser = async (user) => {
  
  
  if(user.constructor.name !== "User"){
    throw new Error("Invalid parameter sent to insertUser() - must be a User model object")
  }

 
  const [isValid, errs] = user.validate()
  
  if(isValid){
    const connection = await pool.getConnection();
    user.salt = "xxx";
    const sql = "INSERT INTO user (UserEmail, UserRoleId, UserActive, UserPassword, UserSalt) VALUES (?, ?, ?, ?, ?)";
    const [result] = await connection.query(sql, [user.email, user.roleId,  user.active, user.password, user.salt]);
    connection.release();
    return result?.insertId;
    
  }else{
    throw new Error("Invalid User - " + JSON.stringify(errs));
  }
}

exports.updateUser = async (user) => {
 
  if(user.constructor.name !== "User"){
    throw new Error("Invalid parameter sent to updateUser() - must be a User model object")
  }

  
  const [isValid, errs] = user.validate()
  
  if(isValid){
    const connection = await pool.getConnection();
    const sql = "UPDATE user SET UserEmail=?, UserRoleId=?, UserActive=?, UserPassword=?, UserSalt=? WHERE UserId=?";
    const [result] = await connection.query(sql, [user.email, user.roleId, user.active, user.password, user.salt, user.id]);
    connection.release();
    return result?.affectedRows === 1 ? true : false;
  }else{
    throw new Error("Invalid User - " + JSON.stringify(errs));
  }
}

exports.deleteUser = async (id) => {
  try{
    const connection = await pool.getConnection();
    const sql = "DELETE FROM user WHERE UserId=?";
    const [result] = await connection.query(sql, [id]);
    connection.release();
    return result.affectedRows === 1 ? true : false;
  }catch(e){
    throw(e);
  }
}