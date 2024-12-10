const User = require("../src/users/user.model");

describe("User Model", () => {

  describe("Constructor", () => {

    it("should set the instance variables properly", ()=>{
      const user = new User({id:1, email: "xx@xx.com", roleId:1, active:true});
      expect(user.id).toBe(1);
      expect(user.email).toBe("xx@xx.com");
      expect(user.roleId).toBe(1);
      expect(user.active).toBe(true);
      expect(user.password).toBe("");
      expect(user.salt).toBe("");
    })

  })

  describe("validate", () => {
    it("should return proper values if all properties are valid", () => {
      const user = new User({id:1, email: "xx@xx.com", roleId:1, active:true});
      const [isValid, errs] = user.validate();
      expect(isValid).toBe(true);
      expect(errs).toEqual({});
      //console.log("user json", JSON.stringify(user));
    })

    it("should return false if the email is empty", () => {
      const user = new User({id:1, email: "", roleId:1, active:true});
      const [isValid, errs] = user.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("email");
    })

    it("should return false if the email is not a valid email address", () => {
      const user = new User({id:1, email: "xxxxxxxxx", roleId:1, active:true});
      const [isValid, errs] = user.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("email");
    })

    it("should return false if the email is longer than 255 characters", () => {
      const user = new User({id:1, email: "x".repeat(256), roleId:1, active:true});
      const [isValid, errs] = user.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("email");
    })

    it("password is NOT required if the user id > 0 (this indicates that the password is not being changed)", () => {
      const user = new User({id:1, email: "xx@xx.com", roleId:1, active:true});
      const [isValid, errs] = user.validate();
      expect(isValid).toBe(true);
    })

    it("password IS required if the user is being inserted (no user ID)", () => {
      const user = new User({email: "xx@xx.com", roleId:1, active:true});
      const [isValid, errs] = user.validate();
      expect(isValid).toBe(false);
      expect(errs).toHaveProperty("password");
    })

    // TODO: add tests to make sure password is strong
  })

})