const request = require('supertest');
const app = require('../src/app.js');

// Here's how we can start a session to run the tests
const sessionAgent = request.agent(app);

describe('API Tests', () => {
  
  describe('Default Route /', () => {
    it('responds with JSON message', async () => {
      //const response = await request(app).get('/');  // this would run the test with a new session?????
      const response = await sessionAgent.get("/");
      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty('message', 'Hello, world!');
    });
  }); // end of Default Route

  describe('404', () => {
    it('responds with 404 status code if the route is not valid', async () => {
      const response = await sessionAgent.get("/SOME-BOGUS-ROUTE");
      expect(response.status).toBe(404);
    });
  }); // end of 404

}); // end of API tests