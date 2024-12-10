const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const SALT_ROUNDS = 8; 
// here's an explanation of salt rounds: https://stackoverflow.com/questions/46693430/what-are-salt-rounds-and-how-are-salts-stored-in-bcrypt

const generateRandomSalt = async () => {
    
  const salt = await bcrypt.genSalt(SALT_ROUNDS);
  //The length of the salt appears to be 29 characters (if it's longer then it will be truncated in the db)
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


// We'll be talking about JWT tokens soon
const getToken = (userId, roleId) => {
  const token = jwt.sign(
      {userId, roleId}, // here's the payload, it has a 'userId' prop and a 'roleId' prop
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
  saltPassword, // we could keep this private (but then we couldn't test it)
  saltAndHashPassword, 
  verifyPassword, 
  getToken,
  decodeToken
}