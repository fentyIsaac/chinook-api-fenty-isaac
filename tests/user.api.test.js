/*
//This version of the tests does not send a token in the Authorization header, 
//there is a version of these tests below that does.

const request = require('supertest');
const app = require('../src/app.js');

const sessionAgent = request.agent(app);

describe("users/", () => {

  describe("GET all users", () => {
    
    it('returns the proper response', async () => {
      const response = await sessionAgent.get("/users");
      expect(response.status).toBe(200);
      
      // check the first user to make sure it has the correct props
      const allUsers = response.body;
      const firstUser = allUsers[0]
      expect(firstUser).toHaveProperty("id");
      expect(firstUser).toHaveProperty("email");
      expect(firstUser).toHaveProperty("roleId");
      
      // Not sure how to handle password and salt (we should never send them)
      // for now will just make sure that  they are both empty strings
      expect(firstUser).toHaveProperty("password", "");
      expect(firstUser).toHaveProperty("salt", "");
    });

  }) // end of GET all users

  describe("GET user by id", () => {
    
    it('returns the proper response', async () => {
      const response = await sessionAgent.get("/users/1");
      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty("id");
      expect(response.body).toHaveProperty("email");
      expect(response.body).toHaveProperty("roleId");
      
      // Not sure how to handle password and salt (we should never send them)
      // for now will just make sure that  they are both empty strings
      expect(response.body).toHaveProperty("password", "");
      expect(response.body).toHaveProperty("salt", "");
    });
    
    it('return a 404 status code if the user id is not valid', async () => {
      const response = await sessionAgent.get("/users/1111111");
      expect(response.status).toBe(404);
    }); 

  }) // end of GET user by id

  
  describe("POST user", () => {
    
    // // NOTE THIS TEST COULD FAIL OR CAUSE A TEST IN user.data.service.test TO FAIL DEPENDING ON THE ORDER THE TESTS RUN!
    // it("should return 201", async () => {
    //   const response = await sessionAgent.post("/users/").send({xxxxxxxxxxxxxx: "xxxxxxxxxxxxxxxxxxxx"});
    //   expect(response.status).toBe(201);
    // })
    
    it("should return 400 if user is not valid", async () => {
      const response = await sessionAgent.post("/users/").send({email: ""}); // invalid, email is empty string
      expect(response.status).toBe(400);
    })

  }) // end of POST user

  describe("PUT user", () => {

    it("should return 200", async () => {
      const idToUpdate = 2;
      userToUpdate = {id:2, email:"andrew@chinookcorp.com", roleId:2, active: true, password:"",salt: ""};
      // NOTE: For PUTs sending an empty string for the password indicates that the password has not changed. 
      const response = await sessionAgent.put("/users/" + idToUpdate).send(userToUpdate);
      expect(response.status).toBe(200);
    })

    it("should return 400 if genre is not valid", async () => {
      const idToUpdate = 2;
      userToUpdate = {id:2, email:"INVALID EMAIL", roleId:2, active: true, password: "",salt: ""};
      const response = await sessionAgent.put("/users/" + idToUpdate).send(userToUpdate);
      expect(response.status).toBe(400);
    })

    it("should return 400 if id in URL does not match id in body", async () => {
      const idToUpdate = 3;
      userToUpdate = {id:2, email:"xxx@xx.com", roleId:2, active: true, password: "",salt: ""};
      const response = await sessionAgent.put("/users/" + idToUpdate).send(userToUpdate); // ids do NOT match
      expect(response.status).toBe(400);
    })

  }) // end of PUT user
  
  describe("DELETE user", () => {

    // // NOTE THIS TEST COULD FAIL OR CAUSE A TEST IN user.data.service.test TO FAIL DEPENDING ON THE ORDER THE TESTS RUN!
    // it("should return 200", async () => {
    //   const idToDelete = 1;
    //   const response = await sessionAgent.delete("/users/" + idToDelete);
    //   expect(response.status).toBe(400);
    // })
    
    it("should return 400 if the id does match a user in the database", async () => {
      const idToDelete = 111111; // Invalid id
      const response = await sessionAgent.delete("/users/" + idToDelete);
      expect(response.status).toBe(400);
    })

  }) // end of DELETE user

})
*/



// This version of the tests sends a token in the Authorization header.
// First we get the token for the admin user:
const {getToken} = require('../src/auth/auth.helpers');
const adminUserId = 1;
const adminRoleId = 1;
const token = "Bearer " + getToken(adminUserId, adminRoleId);

const request = require('supertest');
const app = require('../src/app.js');

const sessionAgent = request.agent(app);

describe("users/", () => {

  describe("Sending requests without a token should result in 403 status code", () => {
    it("should return 403", async () => {
      expect((await sessionAgent.get("/users")).status).toBe(403);
      expect((await sessionAgent.get("/users/11111111")).status).toBe(403);
      expect((await sessionAgent.post("/users/")).status).toBe(403);
      expect((await sessionAgent.put("/users/111111111")).status).toBe(403);
      expect((await sessionAgent.delete("/users/111111111")).status).toBe(403);
    })
  })

  describe("GET all users", () => {
    
    it('returns the proper response', async () => {
      const response = await sessionAgent.get("/users").set('Authorization', token);
      expect(response.status).toBe(200);
      
      // check the first user to make sure it has the correct props
      const allUsers = response.body;
      const firstUser = allUsers[0]
      expect(firstUser).toHaveProperty("id");
      expect(firstUser).toHaveProperty("email");
      expect(firstUser).toHaveProperty("roleId");
      
      // Not sure how to handle password and salt (we should never send them)
      // for now will just make sure that  they are both empty strings
      expect(firstUser).toHaveProperty("password", "");
      expect(firstUser).toHaveProperty("salt", "");
    });

  }) // end of GET all users

  describe("GET user by id", () => {
    
    it('returns the proper response', async () => {
      const response = await sessionAgent.get("/users/1").set('Authorization', token);
      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty("id");
      expect(response.body).toHaveProperty("email");
      expect(response.body).toHaveProperty("roleId");
      
      // Not sure how to handle password and salt (we should never send them)
      // for now will just make sure that  they are both empty strings
      expect(response.body).toHaveProperty("password", "");
      expect(response.body).toHaveProperty("salt", "");
    });
    
    it('return a 404 status code if the user id is not valid', async () => {
      const response = await sessionAgent.get("/users/1111111").set('Authorization', token);
      expect(response.status).toBe(404);
    }); 

  }) // end of GET user by id

  
  describe("POST user", () => {
    
    it("should return 400 if user is not valid", async () => {
      const response = await sessionAgent.post("/users/").set('Authorization', token).send({email: ""}); // invalid, email is empty string
      expect(response.status).toBe(400);
    })

  }) // end of POST user

  describe("PUT user", () => {

    it("should return 200", async () => {
      const idToUpdate = 2;
      userToUpdate = {id:2, email:"andrew@chinookcorp.com", roleId:2, active: true, password:"",salt: ""};
      // NOTE: For PUTs sending an empty string for the password indicates that the password has not changed. 
      const response = await sessionAgent.put("/users/" + idToUpdate).set('Authorization', token).send(userToUpdate);
      expect(response.status).toBe(200);
    })

    it("should return 400 if genre is not valid", async () => {
      const idToUpdate = 2;
      userToUpdate = {id:2, email:"INVALID EMAIL", roleId:2, active: true, password: "",salt: ""};
      const response = await sessionAgent.put("/users/" + idToUpdate).set('Authorization', token).send(userToUpdate);
      expect(response.status).toBe(400);
    })

    it("should return 400 if id in URL does not match id in body", async () => {
      const idToUpdate = 3;
      userToUpdate = {id:2, email:"xxx@xx.com", roleId:2, active: true, password: "",salt: ""};
      const response = await sessionAgent.put("/users/" + idToUpdate).set('Authorization', token).send(userToUpdate); // ids do NOT match
      expect(response.status).toBe(400);
    })

  }) // end of PUT user
  
  describe("DELETE user", () => {

    it("should return 400 if the id does match a user in the database", async () => {
      const idToDelete = 111111; // Invalid id
      const response = await sessionAgent.delete("/users/" + idToDelete).set('Authorization', token);
      expect(response.status).toBe(400);
    })

  }) // end of DELETE user

})