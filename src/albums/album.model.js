class Album{
  constructor({id, title, artistId, artist}){
    this.id = id || 0;
    this.title= title || "";
    this.artistId = artistId || 0; 
    this.artist = artist || "";
  }

  validate(){
    let isValid = true;
    const errorMessages = {};


    

    if(typeof this.id !== 'number' || this.id < 0){
      isValid = false;
      errorMessages.id = "Must be a number greater than or equal to 0";
    }


    

    if(typeof this.title !== 'string'){
      isValid = false;
      errorMessages.title = "Title must be a string";
    } else if(this.title.trim() === '') {
      isValid = false;
      errorMessages.title = "Title cannot be empty";
    }else if(this.title.length > 160){
      isValid = false; 
      errorMessages.title = "Name must be less than or equal to 160 charachters";
    }

    if(typeof this.artistId !== "number" || this.artistId < 0){
      isValid = false;
      errorMessages.artistId = "Artist ID must be a number greater than or equal to 0";
    }

    return[isValid, errorMessages]
  }

}

module.exports = Album;