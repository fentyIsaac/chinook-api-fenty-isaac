const {validateEmailAddress} = require("../utils");
class User {

  constructor({id,email,roleId,active,password,salt}){
		
    this.id = id || 0;
    this.email = email;
    this.roleId = roleId;
    this.active = active;
    this.password = password || "";
    this.salt = salt || "";
  }

  validate(){
    
    let isValid = true;
    const errorMessages = {};
    
    
    //VALIDATE id
    if(isNaN(this.id)){
      errorMessages.id = "The user id must be a number";
      isValid = false;
    }else if (!(this.id >= 0)){
      errorMessages.id = "The number must be greater than or equal to 0";
      isValid = false;
    }
    //VALIDATE email
    if(!this.email){
      errorMessages.email = "Email is required";
      isValid = false;
    }else if(!validateEmailAddress(this.email)){
      errorMessages.email = "Email is not valid";
      isValid = false;
    }else if(this.email.length > 255){
      errorMessages.email = "Email must be shorter than 255";
      isValid = false;
    } 

    //VALIDATE roleId
    if(typeof this.roleId != "number"){
      isValid = false;
      errorMessages.roleId = "The role Id must be a number";
    }else if(!(this.roleId >=1 && this.roleId <= 3)){
      isValid = false;
      errorMessages.roleId = "The role must between a number from 1-3";
    }

    // TODO: VALIDATE active



    // TODO: VALIDATE password
    // Passwords should not be empty for inserts
    // Passwords should be empty for updates
    if(this.id === 0 && !this.password){
      errorMessages.password = "Password is required";
      isValid = false;
    }
    // TODO: VALIDATE salt    
    
    return [isValid, errorMessages]

  }

}

module.exports = User;