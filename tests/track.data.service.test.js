const {getAllTracks, getTrackById, insertTrack, updateTrack, deleteTrack} = require("../src/tracks/track.data.service");
const Track = require("../src/tracks/track.model");

describe("Track Data Service", ()=>{
  
  describe("getAllTracks()", () => {
    
    it('should return all the tracks', async () => {
      const tracks = await getAllTracks();
      // console.log(tracks); // TRY OUT THIS CONSOLE LOG, IT WILL SHOW YOU THE DATA!
      //expect(tracks.length).toBe(98);// this could fail if another tests alters the track table        
      expect(tracks.length).toBeGreaterThanOrEqual(98);        
    });

    it('should return an array of Track objects', async () => {
      const tracks = await getAllTracks();
      expect(tracks[0].constructor.name).toBe("Track");

    });

  }) // end of getAllTracks()
  
  
  describe("getTrackId()", () => {

    it("should get the proper Track when a valid param is passed", async () => {
      // Note: these could fail if another test alters the first track!!!
      const track = await getTrackById(1);
      //console.log("SANITY CHECK:", track); // sanity check
      expect(track.id).toBe(1); 
      expect(track.name).toBe("For Those About To Rock (We Salute You)"); 
      expect(track.albumId).toBe(1); 
      expect(track.album).toBe("For Those About To Rock We Salute You");
      expect(track.genreId).toBe(1);
      expect(track.genre).toBe("Rock");
      expect(track.mediaTypeId).toBe(1);
      expect(track.mediaType).toBe("MPEG audio file");
      expect(track.milliseconds).toBe(343719);
      expect(track.price).toBe(0.99);
    })

    it("should return null if there is no track with the matching id", async () => {
      const track = await getTrackById(1111111111111);
      expect(track).toBe(null);
    })

  }) // end of getTrackById()

  
  describe("insertTrack()", () => {

    it("The returned id should be greater than 0", async () => {

      const newTrack = new Track({
        //id: 0, // ID not required for insert
        name:"some new track",
        albumId:2, 
        //album:"some album", // album not required for insert 
        genreId:3, 
        //genre:"some genre", // genre not required for insert 
        mediaTypeId: 4, 
        //mediaType: "some media type", // mediaType not required for insert 
        milliseconds: 20000, 
        price: 11.00
      });

      const trackId = await insertTrack(newTrack);
      expect(trackId).toBeGreaterThan(0)
    })

    it("should throw error if the parameter is not Track model object", async () => {
      // we expect the error message to include 'Invalid parameter'
      await expect(insertTrack("BLAH")).rejects.toThrow(/Invalid parameter/);
    })
      
    it("should throw error if the Track parameter is not valid", async () => {
      // we expect the error message to include 'Invalid Track'
      await expect(insertTrack(new Track({name:""}))).rejects.toThrow(/Invalid Track/);
    })

    it("should throw an error if the insert violates a FK constraint", async () => {
      // Beware: updating an track in the test db could cause another test to fail (if it uses the same id)
      const newTrack = new Track({
        name:"some track",
        albumId:333333333, // This violates a FK constraint because the ID does not exist in the album table 
        genreId:1, 
        mediaTypeId: 2, 
        milliseconds: 20000, 
        price: 1.99
      });
      await expect(insertTrack(newTrack)).rejects.toThrow(/foreign key constraint fails/);
    })

  }) // end of insertTrack()
  

  
  describe("updateTrack()", () => {

    it("should return true on successful update", async () => {
      // Beware: updating an track in the test db could cause another test to fail (if it uses the same id)
      const trackToUpdate = new Track({
        id: 3,
        name:"Fast as a Gold Fish",
        albumId:3, 
        genreId:1, 
        mediaTypeId: 2, 
        milliseconds: 20000, 
        price: 1.99
      });
      const result = await updateTrack(trackToUpdate);
      expect(result).toBe(true);
    })

    it("should throw an error if the update violates a FK constraint", async () => {
      // Beware: updating an track in the test db could cause another test to fail (if it uses the same id)
      const trackToUpdate = new Track({
        id: 3,
        name:"Fast as a Gold Fish",
        albumId:333333333, // This violates a FK constraint because the ID does not exist in the album table 
        genreId:1, 
        mediaTypeId: 2, 
        milliseconds: 20000, 
        price: 1.99
      });
      await expect(insertTrack(trackToUpdate)).rejects.toThrow(/foreign key constraint fails/);
    })

    it("should return false if there is no matching id", async () => {
      const trackToUpdate = new Track({
        id: 1111111111, // INVALID TRACK ID
        name:"xxxxx",
        albumId:3, 
        genreId:1, 
        mediaTypeId: 2, 
        milliseconds: 20000, 
        price: 1.99
      });
      const result = await updateTrack(trackToUpdate);
      expect(result).toBe(false)
    })

    it("should throw error if the parameter is not an Track model object", async () => {
      // we expect the error message to include 'Invalid parameter'
      await expect(updateTrack("BLAH")).rejects.toThrow(/Invalid parameter/);
    })
      
    it("should throw error if the Track parameter is not valid", async () => {
      // we expect the error message to include 'Invalid Track'
      await expect(updateTrack(new Track({name:""}))).rejects.toThrow(/Invalid Track/);
    })

  }) // end of updateTrack()
  
  
  describe("deleteTrack()", () => {
    // Have to insert a new track before calling a delete function

    it("should return true on successful delete", async () => {
      const newTrack = new Track({
        name:"some new track",
        albumId:2, 
        genreId:3,  
        mediaTypeId: 4, 
        milliseconds: 20000, 
        price: 11.00
      });
      const newTrackId = await insertTrack(newTrack);
      const result = await deleteTrack(newTrackId);
      expect(result).toBe(true)
    })
    
    it("should return false if there is no matching id", async () => {
      const result = await deleteTrack(11111111);
      expect(result).toBe(false)
    })
    
    
    
  }) // end of deleteTrack()
  

}) // end of Track Data Service tests
