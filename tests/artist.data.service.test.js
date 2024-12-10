const {getAllArtists, getArtistById, insertArtist, updateArtist, deleteArtist} = require("../src/artists/artist.data.service");
const Artist = require("../src/artists/artist.model");

describe("Artist Data Service", ()=>{
  
  describe("getAllArtists()", () => {
    
    it('should return all the artists', async () => {
      const artists = await getAllArtists();
      //expect(artists.length).toBe(10);// this could fail if another tests alters the artist table        
      expect(artists.length).toBeGreaterThanOrEqual(10);        
    });

    it('should return an array of Artist objects', async () => {
      const artists = await getAllArtists();
      expect(artists[0].constructor.name).toBe("Artist");

    });

  }) // end of getAllArtists()
  
  describe("getArtistById()", () => {

    it("should get the proper Artist when a valid param is passed", async () => {
      const artist = await getArtistById(1);
      expect(artist.name).toBe("AC/DC"); // Note: this could fail if another tests alters the first Artist
    })

    it("should return null if there is no artist with the matching id", async () => {
      const artist = await getArtistById(1111111111111);
      expect(artist).toBe(null);
    })

  }) // end of getArtistById()

  
  describe("insertArtist()", () => {

    it("The returned id should be greater than 0", async () => {
      const artistId = await insertArtist(new Artist({name:"Some new artist"}));
      expect(artistId).toBeGreaterThan(0)
    })

    it("should throw error if the parameter is not Artist model object", async () => {
      // we expect the error message to include 'Invalid parameter'
      await expect(insertArtist("BLAH")).rejects.toThrow(/Invalid parameter/);
    })
      
    it("should throw error if the Artist parameter is not valid", async () => {
      // we expect the error message to include 'Invalid Artist'
      await expect(insertArtist(new Artist({name:""}))).rejects.toThrow(/Invalid Artist/);
    })

  }) // end of insertArtist()
  
  
  describe("updateArtist()", () => {

    it("should return true on successful update", async () => {
      // Beware: updating an artist in the test db could cause another test to fail (if it uses the same id)
      const result = await updateArtist(new Artist({id:2, name:"Test Artist"}));
      expect(result).toBe(true);
    })

    it("should return false if there is no matching id", async () => {
      const result = await updateArtist(new Artist({id:1111111111, name:"BLAH"}));
      expect(result).toBe(false)
    })

    it("should throw error if the parameter is not an Artist model object", async () => {
      // we expect the error message to include 'Invalid parameter'
      await expect(updateArtist("BLAH")).rejects.toThrow(/Invalid parameter/);
    })
      
    it("should throw error if the Artist parameter is not valid", async () => {
      // we expect the error message to include 'Invalid Artist'
      await expect(updateArtist(new Artist({name:""}))).rejects.toThrow(/Invalid Artist/);
    })

  }) // end of updateArtist()
  
  describe("deleteArtist()", () => {
                
    it("should return true on successful delete", async () => {
      const newArtistId = await insertArtist(new Artist({name:"some new artist"}));
      const result = await deleteArtist(newArtistId);
      expect(result).toBe(true)
    })
    
    it("should return false if there is no matching id", async () => {
      const result = await deleteArtist(11111111);
      expect(result).toBe(false)
    })
    
    it("should throw error if the delete violates a FK constraint", async () => {
      await expect(deleteArtist(1)).rejects.toThrow(/FOREIGN KEY/);
    })
    
  }) // end of deleteArtist()
  

}) // end of Artist Data Service tests
