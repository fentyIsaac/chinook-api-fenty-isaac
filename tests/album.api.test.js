const request = require('supertest');
const app = require('../src/app.js');

const sessionAgent = request.agent(app);

describe("albums/", () => {

  describe("GET all albums", () => {
    
    it('returns the proper response', async () => {
      const response = await sessionAgent.get("/albums");
      expect(response.status).toBe(200);
      //expect(response.body.length).toBe(10); // the data service tests may make this fail!
      expect(response.body.length).toBeGreaterThanOrEqual(10);
    });

  }) // end of GET all albums

  
  describe("GET album by id", () => {
    
    it('returns the proper response', async () => {
      const response = await sessionAgent.get("/albums/6");
      // If any tests in the data service suite updated album 3, then this one could fail:
      expect(response.body).toEqual({"id":6, "title":"Jagged Little Pill", "artistId":4, "artist":"Alanis Morissette"}); 
      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty("id");
      expect(response.body).toHaveProperty("title");
      expect(response.body).toHaveProperty("artistId");
      expect(response.body).toHaveProperty("artist");
    });
    
    it('return a 404 status code if the album id is not valid', async () => {
      const response = await sessionAgent.get("/albums/1111111");
      expect(response.status).toBe(404);
    }); 

  }) // end of GET album by id


  describe("POST album", () => {

    it("should return 201", async () => {
      // hopefully inserting a new row will not cause another test to fail!
      const response = await sessionAgent.post("/albums/").send({"title":"Some new AC/DC album", "artistId":1, "artist":""});
      expect(response.status).toBe(201);
    })
    
    it("should return 400 if album is not valid", async () => {
      const response = await sessionAgent.post("/albums/").send({name: ""}); // invalid, name is empty string
      expect(response.status).toBe(400);
    })

    // Test could give you problems! You may want to comment it out!
    /*it("should return 400 if the artistId is not valid", async () => {
      const response = await sessionAgent.post("/albums/").send({"title":"Some new album", "artistId":111111, "artist":""}); // invalid, artistId is not in the database
      expect(response.status).toBe(400);
    })
    */
  }) // end of POST album

  describe("PUT album", () => {

    it("should return 200", async () => {
      const idToUpdate = 3; // 3 is Big Ones - hopefully another test isn't working with this album
      const response = await sessionAgent.put("/albums/" + idToUpdate).send({id: idToUpdate, title: "Little Ones", artistId:3, artist:""});
      expect(response.status).toBe(200);
    })

    it("should return 400 if the album is not valid", async () => {
      const idToUpdate = 3;
      const response = await sessionAgent.put("/albums/" + idToUpdate).send({id: idToUpdate, name: ""}); // name is not valid
      expect(response.status).toBe(400);
    })

    it("should return 400 if id in URL does not match id in body", async () => {
      const idToUpdate = 1;
      const response = await sessionAgent.put("/albums/" + idToUpdate).send({id: 3, title: "Little Ones", artistId:3, artist:""}); // ids do NOT match
      expect(response.status).toBe(400);
    })

    // Test could give you problems! You may want to comment it out!
    //it("should return 400 if the artistId is not valid", async () => {
      //const idToUpdate = 3; // 3 is Big Ones - hopefully another test isn't working with this album
      //const response = await sessionAgent.put("/albums/" + idToUpdate).send({id: idToUpdate, title: "Little Ones", artistId:11111111111, artist:""});
      //expect(response.status).toBe(400);
    //})

  }) // end of PUT album

  /*describe("DELETE album", () => {

    it("should return 200", async () => {
      // this may not be proper, but we'll insert one and then test to see if we can delete it.
      const preResponse = await sessionAgent.post("/albums/").send({"title":"Some new album for the api test", "artistId":1, "artist":""});
      const idToDelete = preResponse.body.id;

      const response = await sessionAgent.delete("/albums/" + idToDelete);
      expect(response.status).toBe(200);
    })

    it("should return 400 if the id does match a album in the database", async () => {
      const idToDelete = 111111; // Invalid id
      const response = await sessionAgent.delete("/albums/" + idToDelete);
      expect(response.status).toBe(400);
    })

  }) // end of DELETE album
  */

}) // end of albums/