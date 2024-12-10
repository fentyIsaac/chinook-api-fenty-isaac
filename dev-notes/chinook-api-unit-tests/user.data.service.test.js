const {getAllUsers, getUserById, insertUser, updateUser, deleteUser} = require("../src/users/user.data.service");
const User = require("../src/users/user.model");


describe("User Data Service", ()=>{
  
  describe("getAllUsers()", () => {
    
    it('should return 68 users', async () => {
      const users = await getAllUsers();
      expect(users.length).toBe(68);        
    });

    it('should return objects with id, email, roleId, and active properties', async () => {
      const users = await getAllUsers();
      expect(users[0]).toHaveProperty("id");
      expect(users[0]).toHaveProperty("email");
      expect(users[0]).toHaveProperty("roleId");
      expect(users[0]).toHaveProperty("active");
    });

  }) // end of getAllUsers()


  describe("getUserById()", () => {

    it("should get the proper user when a valid param is passed", async () => {
      const user = await getUserById(1);
      //console.log("user", user);
      expect(user.email).toBe("admin@chinookcorp.com")
    })

    it("should return null if there is no user with the matching id", async () => {
      const user = await getUserById(1111111111111);
      expect(user).toBe(null);
    })
  }) // end of getUserById()

  describe("insertUser()", () => {

    it("should return id greater than 0 on successful insert", async () => {
      const userId = await insertUser(new User({"email":"xxxx@xxxx.com","roleId":2,"active":true,"password":"blah"}));
      expect(userId).toBeGreaterThan(0);
    })

    it("should throw error if the parameter is not a User model object", async () => {
      // we expect the error message to include 'Invalid parameter'
      await expect(insertUser("BLAH")).rejects.toThrow(/Invalid parameter/);
    })
      
    it("should throw error if the User parameter is not valid", async () => {
      // we expect the error message to include 'Invalid User'
      await expect(insertUser(new User({"email":"INVALID","roleId":2,"active":true,"password":"blah"}))).rejects.toThrow(/Invalid User/);
    })

  }) // end of insertUser

  describe("updateUser()", () => {

    it("should return true on successful update", async () => {
      const userToUpdate = new User({
        "id":2, 
        "email":"ANDY@chinookcorp.com", 
        "roleId":2, 
        "active": false, 
        "password":"newPassword",
        "salt": "newSalt"
      });
      const result = await updateUser(userToUpdate);
      expect(result).toBe(true)
    })

    
    it("should return false if there is no matching id", async () => {
      const userToUpdate = new User({
        "id":222222222222222, 
        "email":"ANDY@chinookcorp.com", 
        "roleId":2, 
        "active": false, 
        "password":"newPassword",
        "salt": "newSalt"
      });
      const result = await updateUser(userToUpdate);
      expect(result).toBe(false);
    })
    
    it("should throw error if the parameter is not a User model object", async () => {
      // we expect the error message to include 'Invalid parameter'
      await expect(updateUser("BLAH")).rejects.toThrow(/Invalid parameter/);
    })
          
    it("should throw error if the User parameter is not valid", async () => {
      const userToUpdate = new User({
        "id":2, 
        "email":"INVALID EMAIL", 
        "roleId":2, 
        "active": false, 
        "password":"newPassword",
        "salt": "newSalt"
      });
      // we expect the error message to include 'Invalid User'
      await expect(updateUser(userToUpdate)).rejects.toThrow(/Invalid User/);
    })

  }) // end of updateUser()
  

  describe("deleteUser()", () => {
                
    it("should return true on successful delete", async () => {
      const userId = await insertUser(new User({"email":"xxxx@xxxx.com","roleId":2,"active":true,"password":"blah"}));
      const result = await deleteUser(userId);
      expect(result).toBe(true)
    })
    
    it("should return false if there is no matching id", async () => {
      const result = await deleteUser(11111111);
      expect(result).toBe(false)
    })
    
  }) // end of deleteUser()
  
})