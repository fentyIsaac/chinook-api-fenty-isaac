const Genre = require("../src/genres/genre.model");

describe("Genre Model", () => {

  describe("Constructor", () => {

    it("should set the instance variables properly", ()=>{
      const genre = new Genre({id:1, name:"KPop"});
      expect(genre).toHaveProperty("id", 1);
      expect(genre).toHaveProperty("name", "KPop");
    })

    it("id should default to 0 if not included in param", ()=>{
      const genre = new Genre({});
      expect(genre).toHaveProperty("id", 0);
    })

    it("name should default to empty string if not included in param", ()=>{
      const genre = new Genre({});
      expect(genre).toHaveProperty("name", "");
    })

  }) // end of constructor tests

  describe("validate()", () => {

    it("should return proper values if all properties are valid", () => {
      const genre = new Genre({id:1, name:"KPop"});
      const [isValid, errs] = genre.validate();
      expect(isValid).toBe(true);
      expect(errs).toEqual({});
    })

    it("should return proper values if id is NOT valid", () => {
      // invalid id, must be a number
      let genre = new Genre({id:"1", name:"KPop"});
      let [isValid, errs] = genre.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("id");

      // invalid id, must be a number greater than or equal to 0
      genre = new Genre({id:-1, name:"KPop"});
      [isValid, errs] = genre.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("id");
    })

    it("should return proper values if name is NOT valid", () => {
      // invalid name, must be a string
      let genre = new Genre({name:7});
      let [isValid, errs] = genre.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("name");

      // invalid name, must be 120 characters or less
      genre = new Genre({name:"X".repeat(121)});
      [isValid, errs] = genre.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("name");
    })

  }) // end of validate() tests

}) // end of Genre Model