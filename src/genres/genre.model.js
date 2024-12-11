class Genre{

  constructor({id, name}){
    this.id = id || 0;
    this.name = name || "";
  }

  validate(){
    let isValid = true;
    const errorMessages = {};

    
    if(typeof this.id !== 'number' || this.id < 0){
      isValid = false;
      errorMessages.id = 'The ID must be a number greater than  0';
    }
    

    

    if(typeof this.name !== 'string'){
      isValid = false;
      errorMessages.name = 'The name must be a string';
    } else if(this.name.trim() === ''){
      isValid = false;
      errorMessages.name = 'The name cannot be empty';
    } else if (this.name.length > 120){
      isValid = false;
      errorMessages.name = 'The name must be 120 characters or less';
    }


    return [isValid, errorMessages];
  }
}

module.exports = Genre;