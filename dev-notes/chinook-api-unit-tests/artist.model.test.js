const Artist = require("../src/artists/artist.model");

describe("Artist Model", () => {

  describe("Constructor", () => {

    it("should set the instance variables properly", ()=>{
      const artist = new Artist({id:1, name:"Taylor Swift"});
      expect(artist).toHaveProperty("id", 1);
      expect(artist).toHaveProperty("name", "Taylor Swift");
    })

    it("id should default to 0 if not included in param", ()=>{
      const artist = new Artist({});
      expect(artist).toHaveProperty("id", 0);
    })

    it("name should default to empty string if not included in param", ()=>{
      const artist = new Artist({});
      expect(artist).toHaveProperty("name", "");
    })

  }) // end of constructor tests

  describe("validate()", () => {
      
    it("should return proper values if all properties are valid", () => {
      const artist = new Artist({id:1, name:"Taylor Swift"});
      const [isValid, errs] = artist.validate();
      expect(isValid).toBe(true);
      expect(errs).toEqual({});
    })

    it("should return proper values if id is NOT valid", () => {
      // invalid id, must be a number
      let artist = new Artist({id:"1", name:"Taylor Swift"});
      let [isValid, errs] = artist.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("id");

      // invalid id, must be a number greater than or equal to 0
      artist = new Artist({id:-1, name:"Taylor Swift"});
      [isValid, errs] = artist.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("id");
    })

    it("should return proper values if name is NOT valid", () => {
      // invalid name, must be a string
      let artist = new Artist({name:7});
      let [isValid, errs] = artist.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("name");

      // invalid name, must be 120 characters or less
      artist = new Artist({name:"X".repeat(121)});
      [isValid, errs] = artist.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("name");
    })

  }) // end of validate() tests
  
}) 