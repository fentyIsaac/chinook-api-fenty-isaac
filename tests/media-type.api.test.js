const request = require('supertest');
const app = require('../src/app.js');

const sessionAgent = request.agent(app);

describe("media-types/", () => {

  describe("GET all media types", () => {
    
    it('returns the proper response', async () => {
      const response = await sessionAgent.get("/media-types");
      expect(response.status).toBe(200);
      //expect(response.body.length).toBe(5); // the data service tests may make this fail!
      expect(response.body.length).toBeGreaterThan(4);
    });

  }) // end of GET all media types

  
  describe("GET media type by id", () => {
    
    it('returns the proper response', async () => {
      const response = await sessionAgent.get("/media-types/3");
      // If any tests in the data service suite updated media type 3, then this one could fail:
      expect(response.body).toEqual({"id":3,"name":"Protected MPEG-4 video file"}); 
      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty("id");
      expect(response.body).toHaveProperty("name");
    });
    
    it('return a 404 status code if the media type id is not valid', async () => {
      const response = await sessionAgent.get("/media-types/1111111");
      expect(response.status).toBe(404);
    }); 

  }) // end of GET media type by id

 
  describe("POST media type", () => {

    it("should return 201", async () => {
      // hopefully inserting a new row will not cause another test to fail!
      const response = await sessionAgent.post("/media-types/").send({name: "Some new media type"});
      expect(response.status).toBe(201);
    })
    
    it("should return 400 if artist is not valid", async () => {
      const response = await sessionAgent.post("/media-types/").send({name: ""}); // invalid, name is empty string
      expect(response.status).toBe(400);
    })

  }) // end of POST media type

  
  describe("PUT media type", () => {

    it("should return 200", async () => {
      const idToUpdate = 5; // 5 is AAC audio file - hopefully another test isn't working with this media type
      const response = await sessionAgent.put("/media-types/" + idToUpdate).send({id: idToUpdate, name: "AAC AUDIO FILE (all caps)"});
      expect(response.status).toBe(200);
    })

    it("should return 400 if the media type is not valid", async () => {
      const idToUpdate = 1;
      const response = await sessionAgent.put("/media-types/" + idToUpdate).send({id: idToUpdate, name: ""}); // name is not valid
      expect(response.status).toBe(400);
    })

    it("should return 400 if id in URL does not match id in body", async () => {
      const idToUpdate = 1;
      const response = await sessionAgent.put("/media-types/" + idToUpdate).send({id: 2, name: "API update test"}); // ids do NOT match
      expect(response.status).toBe(400);
    })

  }) // end of PUT media type

  
  describe("DELETE media type", () => {

    it("should return 200", async () => {
      // this may not be proper, but we'll insert one and then test to see if we can delete it.
      const preResponse = await sessionAgent.post("/media-types/").send({name: "Some new media type for API test"});
      const idToDelete = preResponse.body.id;

      const response = await sessionAgent.delete("/media-types/" + idToDelete);
      expect(response.status).toBe(200);
    })

    it("should return 400 if the id does match a media-type in the database", async () => {
      const idToDelete = 111111; // Invalid id
      const response = await sessionAgent.delete("/media-types/" + idToDelete);
      expect(response.status).toBe(400);
    })

  }) // end of DELETE media type
  

}) // end of media-types/