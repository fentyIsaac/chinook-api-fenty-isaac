const request = require('supertest');
const app = require('../src/app.js');

const sessionAgent = request.agent(app);

describe("tracks/", () => {

  describe("GET all tracks", () => {
    
    it('returns the proper response', async () => {
      const response = await sessionAgent.get("/tracks");
      expect(response.status).toBe(200);
      //expect(response.body.length).toBe(98); // the data service tests may make this fail!
      expect(response.body.length).toBeGreaterThanOrEqual(98);
    });

  }) // end of GET all tracks

  
  describe("GET track by id", () => {
    
    it('returns the proper response', async () => {
      const response = await sessionAgent.get("/tracks/1");
      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty("id", 1);
      expect(response.body).toHaveProperty("name","For Those About To Rock (We Salute You)");
      expect(response.body).toHaveProperty("albumId",1);
      expect(response.body).toHaveProperty("album","For Those About To Rock We Salute You");
      expect(response.body).toHaveProperty("mediaTypeId",1);
      expect(response.body).toHaveProperty("mediaType","MPEG audio file");
      expect(response.body).toHaveProperty("genreId",1);
      expect(response.body).toHaveProperty("genre", "Rock");
      expect(response.body).toHaveProperty("milliseconds", 343719);
      expect(response.body).toHaveProperty("price", 0.99);
    });
    
    it('return a 404 status code if the track id is not valid', async () => {
      const response = await sessionAgent.get("/tracks/1111111");
      expect(response.status).toBe(404);
    }); 

  }) // end of GET track by id

  
  describe("POST track", () => {
    
    // NOTE THIS TEST COULD FAIL OR CAUSE A TEST IN genre.data.service.test TO FAIL DEPENDING ON THE ORDER THE TESTS RUN!
    it("should return 201", async () => {
      const newTrack = {
        "name":"some new track",
        "albumId":2, 
        "album":"some album", 
        "genreId":3, 
        "genre":"some genre",  
        "mediaTypeId": 4, 
        "mediaType": "some media type",  
        "milliseconds": 20000, 
        "price": 11.00
      }
      const response = await sessionAgent.post("/tracks/").send(newTrack);
      expect(response.status).toBe(201);
      expect(response.body).toHaveProperty("id");
      expect(response.body).toHaveProperty("name", "some new track");
    })

    it("should return 400 if track is not valid", async () => {
      const response = await sessionAgent.post("/tracks/").send({name: ""}); // invalid, name is empty string
      expect(response.status).toBe(400);
    })

  }) // end of POST track

  
  describe("PUT track", () => {

    it("should return 200", async () => {
      // If another test updated this same track, then this could fail
      // Also, since we are updating a track, if another test uses the same track, it may cause the test to fail!
      const updateTrack = {
        "id": 2,
        "name":"Bells to the Well",
        "albumId":2, 
        "album":"xxx", 
        "genreId":3, 
        "genre":"xxx",  
        "mediaTypeId": 4, 
        "mediaType": "xxx",  
        "milliseconds": 20000, 
        "price": 11.00
      }
      const response = await sessionAgent.put("/tracks/" + updateTrack.id).send(updateTrack);
      expect(response.status).toBe(200);
    })

    it("should return 400 if track is not valid", async () => {
      const idToUpdate = 2;
      const response = await sessionAgent.put("/tracks/" + idToUpdate).send({id: idToUpdate, name: ""}); // name is not valid
      expect(response.status).toBe(400);
    })

    it("should return 400 if id in URL does not match id in body", async () => {
      const idToUpdate = 3;
      const response = await sessionAgent.put("/tracks/" + idToUpdate).send({id: 2, name: "blah"}); // ids do NOT match
      expect(response.status).toBe(400);
    })

  }) // end of PUT track

  /*
  describe("DELETE track", () => {

    it("should return 200", async () => {
      // this may not be proper, but we'll insert one and then test to see if we can delete it.
      const track = {
        "name":"some new track",
        "albumId":2, 
        "album":"some album", 
        "genreId":3, 
        "genre":"some genre",  
        "mediaTypeId": 4, 
        "mediaType": "some media type",  
        "milliseconds": 20000, 
        "price": 11.00
      }

      const preResponse = await sessionAgent.post("/tracks/").send(track);
      const idToDelete = preResponse.body.id;

      const response = await sessionAgent.delete("/tracks/" + idToDelete);
      expect(response.status).toBe(200);
    })

    it("should return 400 if the id does match a track in the database", async () => {
      const idToDelete = 111111; // Invalid id
      const response = await sessionAgent.delete("/tracks/" + idToDelete);
      expect(response.status).toBe(400);
    })

  }) // end of DELETE track
  */
}) // end of tracks/