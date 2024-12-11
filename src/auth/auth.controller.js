const {authenticateUser} = require("./auth.data.service")
const {getToken, decodeToken} = require("./auth.helpers");

exports.loginHandler = async (req, res, next) => {
  try{
    const {email,password} = req.body;
    const user = await authenticateUser(email, password);
    
    const token = getToken(user.id, user.roleId);
    res.setHeader("Authorization","Bearer " + token);
    

    res.json(user);
  }catch(err){
    if(err.message.startsWith("Invalid password") || err.message.startsWith("User not found")){
      res.status(401).json({message:"invalid login"});
    }else{
      next(err);
    }
  }
}

exports.logoutHandler = async (req, res, next) => {
  try{
    res.json({message:"Logged Out"});
  }catch(err){
    next(err);
  }
}

exports.isLoggedIn = (req, res, next) => {
  const { authorization } = req.headers
  
  try{
    const token = authorization.substring('Bearer '.length);
    const {userId, roleId, exp} = decodeToken(token);
    const currentTimeInSeconds = Date.now()/1000;
    if(exp < currentTimeInSeconds){
      throw new Error("Token expired");
    }else{
      // TODO: you could use the auth.data.service to see of the user is still active
      next();
      return;
    } 
  }catch(err){
    res.status(403).json({message:"Not Authenticated"})
  }
}
