const Track = require("../src/tracks/track.model");

describe("Track Model", () => {

  describe("Constructor", () => {

    it("should set the instance variables properly", ()=>{
      const track = new Track({
        id:1,
        name:"some track",
        albumId:2, 
        album:"some album", 
        genreId:3, 
        genre:"some genre", 
        mediaTypeId: 4, 
        mediaType: "some media type", 
        milliseconds: 20000, 
        price: 11.00
      });
      expect(track).toHaveProperty("id", 1);
      expect(track).toHaveProperty("name", "some track");
      expect(track).toHaveProperty("albumId", 2);
      expect(track).toHaveProperty("album", "some album");
      expect(track).toHaveProperty("genreId", 3);
      expect(track).toHaveProperty("genre", "some genre");
      expect(track).toHaveProperty("mediaTypeId", 4);
      expect(track).toHaveProperty("mediaType", "some media type");
      expect(track).toHaveProperty("milliseconds", 20000);
      expect(track).toHaveProperty("price", 11.00);
    })

    it("properties should default to proper values if not included in param", ()=>{
      const track = new Track({});
      expect(track).toHaveProperty("id", 0);
      expect(track).toHaveProperty("name", "");
      expect(track).toHaveProperty("albumId", NaN);
      expect(track).toHaveProperty("album", "");
      expect(track).toHaveProperty("genreId", NaN);
      expect(track).toHaveProperty("genre", "");
      expect(track).toHaveProperty("mediaTypeId", NaN);
      expect(track).toHaveProperty("mediaType", "");
      expect(track).toHaveProperty("milliseconds", NaN);
      expect(track).toHaveProperty("price", NaN);
    })

  }) // end of constructor tests

  
  describe("validate()", () => {
      
    it("should return proper values if all properties are valid", () => {
      const track = new Track({
        id:1,
        name:"some track",
        albumId:2, 
        album:"some album", 
        genreId:3, 
        genre:"some genre", 
        mediaTypeId: 4, 
        mediaType: "some media type", 
        milliseconds: 20000, 
        price: 11.00
      });
      const [isValid, errs] = track.validate();
      expect(isValid).toBe(true);
      expect(errs).toEqual({});
    })

    it("should return proper values if id is NOT valid", () => {
      const track = new Track({
        id:"1", // INVALID - must be a number
        name:"some track",
        albumId:2, 
        album:"some album", 
        genreId:3, 
        genre:"some genre", 
        mediaTypeId: 4, 
        mediaType: "some media type", 
        milliseconds: 20000, 
        price: 11.00
      });
      let [isValid, errs] = track.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("id");

      track.id = -1; //INVALID - must be a number greater than or equal to 0
      [isValid, errs] = track.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("id");
    })

    it("should return proper values if name is NOT valid", () => {
      const track = new Track({
        id:1, 
        name:7, // INVALID - must be a string
        albumId:2, 
        album:"some album", 
        genreId:3, 
        genre:"some genre", 
        mediaTypeId: 4, 
        mediaType: "some media type", 
        milliseconds: 20000, 
        price: 11.00
      });

      let [isValid, errs] = track.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("name");

      
      track.name = "X".repeat(201); // invalid name, must be 200 characters or less
      [isValid, errs] = track.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("name");
    })

    it("should return proper values if albumId is NOT valid", () => {
      const track = new Track({
        id:1,
        name:"some track",
        albumId:"X",  // INVALID - must be a number 
        album:"some album", 
        genreId:3, 
        genre:"some genre", 
        mediaTypeId: 4, 
        mediaType: "some media type", 
        milliseconds: 20000, 
        price: 11.00
      });
      let [isValid, errs] = track.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("albumId");

      track.albumId = -1; //INVALID - must be a number greater than or equal to 0
      [isValid, errs] = track.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("albumId");
    })

    it("should return proper values if genreId is NOT valid", () => {
      const track = new Track({
        id:1,
        name:"some track",
        albumId:2,  
        album:"some album", 
        genreId:"X", // INVALID - must be a number  
        genre:"some genre", 
        mediaTypeId: 4, 
        mediaType: "some media type", 
        milliseconds: 20000, 
        price: 11.00
      });
      let [isValid, errs] = track.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("genreId");

      track.genreId = -1; //INVALID - must be a number greater than or equal to 0
      [isValid, errs] = track.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("genreId");
    })

    it("should return proper values if mediaTypeId is NOT valid", () => {
      const track = new Track({
        id:1,
        name:"some track",
        albumId:2,  
        album:"some album", 
        genreId:3,   
        genre:"some genre", 
        mediaTypeId: "X", // INVALID - must be a number 
        mediaType: "some media type", 
        milliseconds: 20000, 
        price: 11.00
      });
      let [isValid, errs] = track.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("mediaTypeId");

      track.mediaTypeId = -1; //INVALID - must be a number greater than or equal to 0
      [isValid, errs] = track.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("mediaTypeId");
    })

    it("should return proper values if milliseconds is NOT valid", () => {
      const track = new Track({
        id:1,
        name:"some track",
        albumId:2,  
        album:"some album", 
        genreId:3,   
        genre:"some genre", 
        mediaTypeId: 4, 
        mediaType: "some media type", 
        milliseconds: "xxx",  // INVALID - must be a number 
        price: 11.00
      });
      let [isValid, errs] = track.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("milliseconds");

      track.milliseconds = -1; //INVALID - must be a number greater than or equal to 0
      [isValid, errs] = track.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("milliseconds");
    })

    it("should return proper values if price is NOT valid", () => {
      const track = new Track({
        id:1,
        name:"some track",
        albumId:2,  
        album:"some album", 
        genreId:3,   
        genre:"some genre", 
        mediaTypeId: 4, 
        mediaType: "some media type", 
        milliseconds: 20000,  
        price: "X" // INVALID - must be a number 
      });
      let [isValid, errs] = track.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("price");

      track.price = -1; //INVALID - must be a number greater than or equal to 0
      [isValid, errs] = track.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("price");
    })
    

  }) // end of validate() tests
  
  
}) 