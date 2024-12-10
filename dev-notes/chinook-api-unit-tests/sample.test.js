require('dotenv').config();

//console.log("NODE_ENV: ", process.env.NODE_ENV);

describe('Sample Test', () => {
  it('should be false', () => {
    expect(5 > 6).toBe(false);
  });
});