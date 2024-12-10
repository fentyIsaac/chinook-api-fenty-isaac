const request = require('supertest');
const app = require('../src/app.js');

const sessionAgent = request.agent(app);

describe("artists/", () => {

  describe("GET all artists", () => {
    
    it('returns the proper response', async () => {
      const response = await sessionAgent.get("/artists");
      expect(response.status).toBe(200);
      //expect(response.body.length).toBe(10); // the data service tests may make this fail!
      expect(response.body.length).toBeGreaterThanOrEqual(10);
    });

  }) // end of GET all artists

  describe("GET artist by id", () => {
    
    it('returns the proper response', async () => {
      const response = await sessionAgent.get("/artists/3");
      // If any tests in the data service suite updated artist 3, then this one could fail:
      expect(response.body).toEqual({"id":3,"name":"Aerosmith"}); 
      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty("id");
      expect(response.body).toHaveProperty("name");
    });
    
    it('return a 404 status code if the artist id is not valid', async () => {
      const response = await sessionAgent.get("/artists/1111111");
      expect(response.status).toBe(404);
    }); 

  }) // end of GET artist by id

  describe("POST artist", () => {

    it("should return 201", async () => {
      // hopefully inserting a new row will not cause another test to fail!
      const response = await sessionAgent.post("/artists/").send({name: "Some new artist for API test"});
      expect(response.status).toBe(201);
    })
    
    it("should return 400 if artist is not valid", async () => {
      const response = await sessionAgent.post("/artists/").send({name: ""}); // invalid, name is empty string
      expect(response.status).toBe(400);
    })

  }) // end of POST artist

  describe("PUT artist", () => {

    it("should return 200", async () => {
      const idToUpdate = 5; // 5 is Alice In Chains - hopefully another test isn't working with this artist
      const response = await sessionAgent.put("/artists/" + idToUpdate).send({id: idToUpdate, name: "Alex in Chains"});
      expect(response.status).toBe(200);
    })

    it("should return 400 if the artist is not valid", async () => {
      const idToUpdate = 1;
      const response = await sessionAgent.put("/artists/" + idToUpdate).send({id: idToUpdate, name: ""}); // name is not valid
      expect(response.status).toBe(400);
    })

    it("should return 400 if id in URL does not match id in body", async () => {
      const idToUpdate = 1;
      const response = await sessionAgent.put("/artists/" + idToUpdate).send({id: 2, name: "API update test"}); // ids do NOT match
      expect(response.status).toBe(400);
    })

  }) // end of PUT artist

  describe("DELETE artist", () => {

    it("should return 200", async () => {
      // this may not be proper, but we'll insert one and then test to see if we can delete it.
      const preResponse = await sessionAgent.post("/artists/").send({name: "Some new artist for API test"});
      const idToDelete = preResponse.body.id;

      const response = await sessionAgent.delete("/artists/" + idToDelete);
      expect(response.status).toBe(200);
    })

    it("should return 400 if the id does match a artist in the database", async () => {
      const idToDelete = 111111; // Invalid id
      const response = await sessionAgent.delete("/artists/" + idToDelete);
      expect(response.status).toBe(400);
    })

  }) // end of DELETE artist


}) // end of artists/