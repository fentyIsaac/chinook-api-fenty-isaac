const { authenticateUser } = require("../src/auth/auth.data.service");

describe("Auth Data Service", ()=>{
  
  describe("authenticateUser()", () => {
    
    it('should authenticate the admin user', async () => {
        const adminUser = await authenticateUser("admin@chinookcorp.com", "test123");
        expect(adminUser).toBeTruthy();
        expect(adminUser).toHaveProperty("email", "admin@chinookcorp.com");
        //console.log("ADMIN USER:", adminUser);
    });

    it('should throw an error if the email does not exist in the database', async () => {
      await expect(authenticateUser("BLAH@BLAH.com", "test123")).rejects.toThrow(/User not found/);
    });

    it('should throw an error if the password is not correct', async () => {
      await expect(authenticateUser("admin@chinookcorp.com", "BLAH")).rejects.toThrow(/Invalid password/);
    });

  });

});