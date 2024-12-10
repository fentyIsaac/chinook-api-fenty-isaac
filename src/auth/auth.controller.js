const {authenticateUser} = require("./auth.data.service")

exports.loginHandler = async (req, res, next) => {
  try{
    const {email,password} = req.body;
    const user = await authenticateUser(email, password);
    // TODO: set JWT
    res.json(user);
  }catch(err){
    if(err.message.startsWith("Invalid password") || err.message.startsWith("User not found")){
      res.status(401).json({message:"invalid login"});
    }else{
      next(err);
    }
  }
}

// Since we are using JWT tokens instead of cookies, there is no way to log out!
exports.logoutHandler = async (req, res, next) => {
  try{
    res.json({message:"TODO: log out"});
  }catch(err){
    next(err);
  }
}
