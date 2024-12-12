const {getAllUsers, getUserById, insertUser, updateUser, deleteUser} = require("./user.data.service");
const User = require("./user.model");
const { use } = require("./user.routes");

exports.getAllHandler = async (req, res, next) => {
  try{
  const users = await getAllUsers();
  const cleanedUsers = users.map((user)  => {
    user.password = "";
    user.salt = "";
    return user;
  });

  res.json(cleanedUsers);
  }catch(err){
    next(err);
  }
}

exports.getByIdHandler = async (req, res, next) => {
  try{
    const user = await getUserById(req.params.id);

    if(!user){
      return res.status(404).json({message: "User was not found"});
    }

    user.password = "";
    user.salt = "";
    
    res.status(200).json(user)
  }catch(err){
    next(err);
  }
}

exports.insertHandler = async (req, res, next) => {
  try{
    
    const user = new User(req.body);

    
    const [isValid, errors] = user.validate();

    if(isValid){
      user.id = await insertUser(user);
      res.status(201).json(user);
    }else{
      res.status(400).json({message:"failed - invalid"});
    }
    
  }catch(err){
    next(err);
  }
}

exports.updateHandler = async (req, res, next) => {
  try{
    if(req.params.id == req.body.id){

      
      const user = new User(req.body);

      
      const [isValid, errors] = user.validate();

      if(isValid){
        const result = await updateUser(user);
        if(result === true){
          res.status(200).json({message:"success"});
        }else{
          res.status(400).json({message:"failed to update",});
        }
      }else{
        res.status(400).json({message:"failed - invalid",});
      }

    }else{
      res.status(400).json({message:"failed - id mismatch"});
    }
  }catch(err){
    next(err);
  }
}

exports.deleteHandler = async (req, res, next) => {
  try{
    const result = await deleteUser(req.params.id);
    if(result === true){
      res.status(200).json({message:"success"}); 
    }else{
      res.status(400).json({message:"failed"});
    }
  }catch(err){
    next(err);
  }
}
