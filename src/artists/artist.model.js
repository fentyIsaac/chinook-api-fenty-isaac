class Artist {
  constructor({id, name}){
    this.id = id|| 0;
    this.name = name || "";
  }

  validate(){
    let isValid = true;
    const errorMessages = {};

    if(typeof this.id !== 'number' || this.id < 0){
      isValid = false;
      errorMessages.id = 'The Id must be greater than 0';
    }

    if(typeof this.name !== 'string'){
      isValid = false;
      errorMessages.name = 'Name must be a string';
    } else if(this.name.trim() === ''){
      isValid = false;
      errorMessages.name = 'Name cannot be empty';
    }else if(this.name.length > 120 ){
      isValid = false;
      errorMessages.name = 'Must be less than 120 charachters';
    }

    return [isValid, errorMessages];
  }
  
}

module.exports = Artist;