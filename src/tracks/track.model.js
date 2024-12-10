class Track {

  constructor({id, name , albumId , album , genreId ,genre, mediaTypeId ,mediaType , milliseconds , price}){
		
    this.id = id || 0;
    this.name = name || "";
    this.albumId = albumId || NaN;
    this.album = album || "";
    this.genreId = genreId || NaN;
    this.genre = genre || "";
    this.mediaTypeId = mediaTypeId || NaN;
    this.mediaType = mediaType || "";
    this.milliseconds = milliseconds || NaN;
    this.price = price || NaN;
  }

  validate() {
    let isValid = true;
    const errorMessages = {};

    // Validate id
    if (typeof this.id !== 'number' || isNaN(this.id) || this.id < 0) {
        errorMessages.id = 'ID must be a valid number greater than or equal to 0';
        isValid = false;
    }

    // Validate name
    if (typeof this.name !== 'string' || this.name.length > 200) {
        errorMessages.name = 'Name must be a string and 200 characters or less';
        isValid = false;
    }

    // Validate albumId
    if (typeof this.albumId !== 'number' || isNaN(this.albumId) || this.albumId < 0) {
        errorMessages.albumId = 'AlbumId must be a valid number greater than or equal to 0';
        isValid = false;
    }

    // Validate album
    if (typeof this.album !== 'string') {
        errorMessages.album = 'Album must be a string';
        isValid = false;
    }

    // Validate genreId
    if (typeof this.genreId !== 'number' || isNaN(this.genreId) || this.genreId < 0) {
        errorMessages.genreId = 'GenreId must be a valid number greater than or equal to 0';
        isValid = false;
    }

    // Validate genre
    if (typeof this.genre !== 'string') {
        errorMessages.genre = 'Genre must be a string';
        isValid = false;
    }

    // Validate mediaTypeId
    if (typeof this.mediaTypeId !== 'number' || isNaN(this.mediaTypeId) || this.mediaTypeId < 0) {
        errorMessages.mediaTypeId = 'MediaTypeId must be a valid number greater than or equal to 0';
        isValid = false;
    }

    // Validate mediaType
    if (typeof this.mediaType !== 'string') {
        errorMessages.mediaType = 'MediaType must be a string';
        isValid = false;
    }

    // Validate milliseconds
    if (typeof this.milliseconds !== 'number' || isNaN(this.milliseconds) || this.milliseconds < 0) {
        errorMessages.milliseconds = 'Milliseconds must be a valid number greater than or equal to 0';
        isValid = false;
    }

    // Validate price
    if (typeof this.price !== 'number' || isNaN(this.price) || this.price < 0) {
        errorMessages.price = 'Price must be a valid number greater than or equal to 0';
        isValid = false;
    }

    return [isValid, errorMessages];
}



}
  
module.exports = Track;
