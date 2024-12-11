const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const SALT_ROUNDS = 8; 


const generateRandomSalt = async () => {
    
  const salt = await bcrypt.genSalt(SALT_ROUNDS);
  
  return salt;
}

const saltPassword = (salt, password) => {
    return salt + password + salt;
}

const saltAndHashPassword = async (salt,password) => {
    const saltedPassword = saltPassword(salt, password)
    return await bcrypt.hash(saltedPassword, SALT_ROUNDS);
}

const verifyPassword = async (password, salt, hashedPassword) => {
    const saltedPassword = saltPassword(salt, password);
    const result = await bcrypt.compare(saltedPassword, hashedPassword);
    return result;
}



const getToken = (userId, roleId) => {
  const token = jwt.sign(
      {userId, roleId}, 
      process.env.JWT_SECRET, 
      {expiresIn: process.env.JWT_EXPIRES_IN} 
  );

  return token;
}

const decodeToken = (token) => {
  return jwt.verify(token, process.env.JWT_SECRET)
}


module.exports = {
  generateRandomSalt,
  saltPassword, 
  saltAndHashPassword, 
  verifyPassword, 
  getToken,
  decodeToken
}