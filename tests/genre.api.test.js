const request = require('supertest');
const app = require('../src/app.js');

const sessionAgent = request.agent(app);

describe("genres/", () => {

  describe("GET all genres", () => {
    
    it('returns the proper response', async () => {
      const response = await sessionAgent.get("/genres");
      expect(response.status).toBe(200);
      //expect(response.body.length).toBe(25); // the data service tests may make this fail!
      expect(response.body.length).toBeGreaterThan(24);
    });

  }) // end of GET all genres

  describe("GET genre by id", () => {
    
    it('returns the proper response', async () => {
      //const response = await sessionAgent.get("/genres/1");
      //expect(response.body).toEqual({"id":1,"name":"Rock"}); // The data service tests may change the db and make this fail!!!
      const response = await sessionAgent.get("/genres/3");
      expect(response.body).toEqual({"id":3,"name":"Metal"}); // We need to make sure that no other tests mess with 'Metal'!
      
      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty("id");
      expect(response.body).toHaveProperty("name");
    });
    
    it('return a 404 status code if the genre id is not valid', async () => {
      const response = await sessionAgent.get("/genres/1111111");
      expect(response.status).toBe(404);
    }); 

  }) // end of GET genre by id

  describe("POST genre", () => {
    
    // NOTE THIS TEST COULD FAIL OR CAUSE A TEST IN genre.data.service.test TO FAIL DEPENDING ON THE ORDER THE TESTS RUN!
    it("should return 201", async () => {
      const response = await sessionAgent.post("/genres/").send({name: "Some new genre for API test"});
      expect(response.status).toBe(201);
      expect(response.body).toHaveProperty("id");
      expect(response.body).toHaveProperty("name", "Some new genre for API test");
    })

    it("should return 400 if genre is not valid", async () => {
      const response = await sessionAgent.post("/genres/").send({name: ""}); // invalid, name is empty string
      expect(response.status).toBe(400);
    })

  }) // end of POST genre

  describe("PUT genre", () => {

    it("should return 200", async () => {
      // If another test updated this same genre, then this could fail
      // Also, since we are updating a genre, if another test uses the same genre, it may cause the test to fail!
      const idToUpdate = 7; 
      const response = await sessionAgent.put("/genres/" + idToUpdate).send({id: idToUpdate, name: "Latin Music"});
      expect(response.status).toBe(200);
    })

    it("should return 400 if genre is not valid", async () => {
      const idToUpdate = 1;
      const response = await sessionAgent.put("/genres/" + idToUpdate).send({id: idToUpdate, name: ""}); // name is not valid
      expect(response.status).toBe(400);
    })

    it("should return 400 if id in URL does not match id in body", async () => {
      const idToUpdate = 1;
      const response = await sessionAgent.put("/genres/" + idToUpdate).send({id: 2, name: "API update test"}); // ids do NOT match
      expect(response.status).toBe(400);
    })

  }) // end of PUT genre

  describe("DELETE genre", () => {

    it("should return 200", async () => {
      // this may not be proper, but we'll insert one and then test to see if we can delete it.
      const preResponse = await sessionAgent.post("/genres/").send({name: "Some new genre for API test"});
      const idToDelete = preResponse.body.id;

      const response = await sessionAgent.delete("/genres/" + idToDelete);
      expect(response.status).toBe(200);
    })

    it("should return 400 if the id does match a genre in the database", async () => {
      const idToDelete = 111111; // Invalid id
      const response = await sessionAgent.delete("/genres/" + idToDelete);
      expect(response.status).toBe(400);
    })

  }) // end of DELETE genre



}) // end of genres/