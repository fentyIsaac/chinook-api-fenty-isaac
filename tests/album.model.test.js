const Album = require("../src/albums/album.model");

describe("Album Model", () => {

  describe("Constructor", () => {

    it("should set the instance variables properly", ()=>{
      const album = new Album({id:1, title:"The White Album", artistId:1111, artist:"The Beatles"});
      expect(album).toHaveProperty("id", 1);
      expect(album).toHaveProperty("title", "The White Album");
      expect(album).toHaveProperty("artistId", 1111);
      expect(album).toHaveProperty("artist", "The Beatles");
    })

    it("properties should be set to their default if not included in param", ()=>{
      const album = new Album({});
      expect(album).toHaveProperty("id", 0);
      expect(album).toHaveProperty("title", "");
      expect(album).toHaveProperty("artistId", 0);
      expect(album).toHaveProperty("artist", "");
    })

  }) // end of constructor tests

  describe("validate()", () => {
      
    it("should return proper values if all properties are valid", () => {
      const album = new Album({id:1, title:"The White Album", artistId:1111, artist:"The Beatles"});
      const [isValid, errs] = album.validate();
      expect(isValid).toBe(true);
      expect(errs).toEqual({});
    })

    it("should return proper values if id is NOT valid", () => {
      // invalid id, must be a number
      let album = new Album({id:"BLAH", title:"The White Album", artistId:1111, artist:"The Beatles"});
      let [isValid, errs] = album.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("id");

      // invalid id, must be a number greater than or equal to 0
      album = new Album({id:-1, title:"The White Album", artistId:1111, artist:"The Beatles"});
      [isValid, errs] = album.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("id");
    })

    it("should return proper values if title is NOT valid", () => {
      // invalid name, must be a string
      let album = new Album({title:7});
      let [isValid, errs] = album.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("title");

      // invalid name, must be 160 characters or less
      album = new Album({title:"X".repeat(161)});
      [isValid, errs] = album.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("title");
    })

    it("should return proper values if artistId is NOT valid", () => {
      // invalid artistId, must be a number
      let album = new Album({id:1, title:"The White Album", artistId:"BLAH", artist:"The Beatles"});
      let [isValid, errs] = album.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("artistId");

      // invalid artistId, must be a number greater than or equal to 0
      album = new Album({id:1, title:"The White Album", artistId:-1, artist:"The Beatles"});
      [isValid, errs] = album.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("artistId");
    })

  }) // end of validate() tests
  
}) 