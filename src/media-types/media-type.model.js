class MediaType {

  constructor({id = 0, name = ''}){
		
    this.id = id;
    this.name = name; 
  }

  validate(){
    
    let isValid = true;
    const errorMessages = {};
    
    
    
       
    if(typeof this.id !== 'number' || this.id < 0){
      isValid = false;
      errorMessages.id = "The ID must be greater than 0";
    }

    if(typeof this.name !== 'string'){
      isValid = false;
      errorMessages.name = "Name must be a string";
    }else if(this.name.trim() === ''){
      isValid = false;
      errorMessages.id = "Name cannot be empty";
    }else if(this.name.length > 120){
      isValid = false;
      errorMessages.name = "Name has to be 120 charachters or less";
    }
    
    return [isValid, errorMessages]

  }

}
  
module.exports = MediaType;