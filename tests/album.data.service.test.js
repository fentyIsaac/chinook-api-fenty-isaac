const {getAllAlbums, getAlbumById, insertAlbum, updateAlbum, deleteAlbum} = require("../src/albums/album.data.service");
const Album = require("../src/albums/album.model");

describe("Album Data Service", ()=>{
  
  describe("getAllAlbums()", () => {
    
    it('should return all the albums', async () => {
      const albums = await getAllAlbums();
      //expect(albums.length).toBe(10);// this could fail if another tests alters the album table        
      expect(albums.length).toBeGreaterThanOrEqual(10);        
    });

    it('should return an array of Album objects', async () => {
      const albums = await getAllAlbums();
      expect(albums[0].constructor.name).toBe("Album");

    });

  }) // end of getAllAlbums()
  
  describe("getAlbumById()", () => {

    it("should get the proper Album when a valid param is passed", async () => {
      const album = await getAlbumById(1);
      expect(album.title).toBe("For Those About To Rock We Salute You"); // Note: this could fail if another tests alters the first Album
      expect(album.artistId).toBe(1); // Note: this could fail if another tests alters the first Album
      expect(album.artist).toBe("AC/DC"); // Note: this could fail if another tests alters the first Album
    })

    it("should return null if there is no album with the matching id", async () => {
      const album = await getAlbumById(1111111111111);
      expect(album).toBe(null);
    })

  }) // end of getAlbumById()

  
  describe("insertAlbum()", () => {

    it("The returned id should be greater than 0", async () => {
      const albumId = await insertAlbum(new Album({title:"Some new AC/DC album", artistId:1, artist:""}));
      expect(albumId).toBeGreaterThan(0)
    })

    it("should throw error if the parameter is not Album model object", async () => {
      // we expect the error message to include 'Invalid parameter'
      await expect(insertAlbum("BLAH")).rejects.toThrow(/Invalid parameter/);
    })
      
    it("should throw error if the Album parameter is not valid", async () => {
      // we expect the error message to include 'Invalid Album'
      await expect(insertAlbum(new Album({title:""}))).rejects.toThrow(/Invalid Album/);
    })

  }) // end of insertAlbum()
  
  describe("updateAlbum()", () => {

    it("should return true on successful update", async () => {
      // Beware: updating an album in the test db could cause another test to fail (if it uses the same id)
      const result = await updateAlbum(new Album({id:2, title:"Bells to the Wells", artistId:1, artist:""}));
      expect(result).toBe(true);
    })

    it("should return false if there is no matching id", async () => {
      const result = await updateAlbum(new Album({id:1111111111, title:"XXX", artistId:1, artist:""}));
      expect(result).toBe(false)
    })

    it("should throw error if the parameter is not an Album model object", async () => {
      // we expect the error message to include 'Invalid parameter'
      await expect(updateAlbum("BLAH")).rejects.toThrow(/Invalid parameter/);
    })
      
    it("should throw error if the Album parameter is not valid", async () => {
      // we expect the error message to include 'Invalid Album'
      await expect(updateAlbum(new Album({title:""}))).rejects.toThrow(/Invalid Album/);
    })

  }) // end of updateAlbum()
  
  describe("deleteAlbum()", () => {
                
    it("should return true on successful delete", async () => {
      const newAlbumId = await insertAlbum(new Album({title:"some new album", artistId:1}));
      const result = await deleteAlbum(newAlbumId);
      expect(result).toBe(true)
    })
    
    it("should return false if there is no matching id", async () => {
      const result = await deleteAlbum(11111111);
      expect(result).toBe(false)
    })
    
    it("should throw error if the delete violates a FK constraint", async () => {
      await expect(deleteAlbum(1)).rejects.toThrow(/FOREIGN KEY/);
    })
    
  }) // end of deleteAlbum()

}) // end of Album Data Service tests
