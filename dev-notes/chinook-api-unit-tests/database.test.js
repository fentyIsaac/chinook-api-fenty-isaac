// Here's a good reference on running queries with mysql2:
// https://sidorares.github.io/node-mysql2/docs
const pool = require("../src/db");

// afterAll(async () => {
//   await pool.end();
// })

describe('Database Tests', () => {
  
  it('pool.getConnection() should return truthy', async () => {
    const connection = await pool.getConnection();
    expect(connection).toBeTruthy();
    connection.release(); // you should 'release' the connection when you're done with it
  });

  /*
  it('There should be 68 rows in the user table', async () => {
    const connection = await pool.getConnection();
    const sql = "SELECT * FROM user"
    const [rows, fields] = await connection.query(sql);
    //console.log(rows); // rows contains rows returned by server
    //console.log(fields); // fields contains extra meta data about results, if available
    expect(rows.length).toBe(68)
    connection.release();
  });

  it('The user with the ID of 1 should be admin@chinookcorp.com', async () => {
    const connection = await pool.getConnection();
    const sql = "SELECT * FROM user WHERE UserId = ?"
    const someId = 1;
    const [rows] = await connection.query(sql,[someId]);
    expect(rows.length).toBe(1)
    expect(rows[0].UserEmail).toBe("admin@chinookcorp.com")
    connection.release();
  });
  */
  

  /*
  describe("Genre Data Service", ()=>{
    
    describe("getAllGenres()", () => {
      
      it('should return 25 genres', async () => {
        const genres = await getAllGenres();
        expect(genres.length).toBe(25);        
      });

      it('should return an array of Genre objects', async () => {
        const genres = await getAllGenres();
        expect(genres[0].constructor.name).toBe("Genre");

      });

    }) // end of getAllGenres()

    describe("getGenreById()", () => {

      it("should get the proper Genre when a valid param is passed", async () => {
        const genre = await getGenreById(1);
        //console.log("genre", genre);
        expect(genre.name).toBe("Rock");
      })
  
      it("should return null if there is no genre with the matching id", async () => {
        const genre = await getGenreById(1111111111111);
        expect(genre).toBe(null);
      })

    }) // end of getGenreById()

    describe("insertGenre()", () => {

      it("The returned id should be greater than 0", async () => {
        const genreId = await insertGenre(new Genre({name:"Some new genre"}));
        expect(genreId).toBeGreaterThan(0)
      })

      it("should throw error if the parameter is not a Genre model object", async () => {
        // we expect the error message to include 'Invalid parameter'
        await expect(insertGenre("BLAH")).rejects.toThrow(/Invalid parameter/);
      })
        
      it("should throw error if the Genre parameter is not valid", async () => {
        // we expect the error message to include 'Invalid Genre'
        await expect(insertGenre(new Genre({name:""}))).rejects.toThrow(/Invalid Genre/);
      })

    }) // end of insertGenre()

    describe("updateGenre()", () => {

      it("should return true on successful update", async () => {
        const result = await updateGenre(new Genre({id:1, name:"Rock-n-Roll"}));
        expect(result).toBe(true)
      })

      it("should return false if there is no matching id", async () => {
        const result = await updateGenre(new Genre({id:1111111111, name:"Rock-n-Roll"}));
        expect(result).toBe(false)
      })

      it("should throw error if the parameter is not a Genre model object", async () => {
        // we expect the error message to include 'Invalid parameter'
        await expect(updateGenre("BLAH")).rejects.toThrow(/Invalid parameter/);
      })
        
      it("should throw error if the Genre parameter is not valid", async () => {
        // we expect the error message to include 'Invalid Genre'
        await expect(updateGenre(new Genre({name:""}))).rejects.toThrow(/Invalid Genre/);
      })

    }) // end of updateGenre()

    describe("deleteGenre()", () => {
                 
      it("should return true on successful delete", async () => {
        const newGenreId = await insertGenre(new Genre({name:"some new genre"}));
        const result = await deleteGenre(newGenreId);
        expect(result).toBe(true)
      })
      
      it("should return false if there is no matching id", async () => {
        const result = await deleteGenre(11111111);
        expect(result).toBe(false)
      })
      
      it("should throw error if the delete violates a FK constraint", async () => {
        await expect(deleteGenre(1)).rejects.toThrow(/FOREIGN KEY/);
      })
      
    }) // end of deleteGenre()

  

  }) // end of Genre Data Service tests
  */

});



