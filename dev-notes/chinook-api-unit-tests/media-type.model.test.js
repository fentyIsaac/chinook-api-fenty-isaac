const MediaType = require("../src/media-types/media-type.model");

describe("MediaType Model", () => {

  describe("Constructor", () => {

    it("should set the instance variables properly", ()=>{
      const mediaType = new MediaType({id:1, name:"MP3"});
      expect(mediaType).toHaveProperty("id", 1);
      expect(mediaType).toHaveProperty("name", "MP3");
    })

    it("id should default to 0 if not included in param", ()=>{
      const mediaType = new MediaType({});
      expect(mediaType).toHaveProperty("id", 0);
    })

    it("name should default to empty string if not included in param", ()=>{
      const mediaType = new MediaType({});
      expect(mediaType).toHaveProperty("name", "");
    })

  }) // end of constructor tests


  describe("validate()", () => {
      
    it("should return proper values if all properties are valid", () => {
      const mediaType = new MediaType({id:1, name:"MP3"});
      const [isValid, errs] = mediaType.validate();
      expect(isValid).toBe(true);
      expect(errs).toEqual({});
    })

    it("should return proper values if id is NOT valid", () => {
      // invalid id, must be a number
      let mediaType = new MediaType({id:"1", name:"MP3"});
      let [isValid, errs] = mediaType.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("id");

      // invalid id, must be a number greater than or equal to 0
      mediaType = new MediaType({id:-1, name:"MP3"});
      [isValid, errs] = mediaType.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("id");
    })

    it("should return proper values if name is NOT valid", () => {
      // invalid name, must be a string
      let mediaType = new MediaType({name:7});
      let [isValid, errs] = mediaType.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("name");

      // invalid name, must be 120 characters or less
      mediaType = new MediaType({name:"X".repeat(121)});
      [isValid, errs] = mediaType.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("name");
    })

  }) // end of validate() tests
  
}) 