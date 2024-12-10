const {getAllMediaTypes, getMediaTypeById, insertMediaType, updateMediaType, deleteMediaType} = require("../src/media-types/media-type.data.service");
const MediaType = require("../src/media-types/media-type.model");

describe("MediaType Data Service", ()=>{
  
  describe("getAllMediaTypes()", () => {
    
    it('should return all the media types', async () => {
      const mediaTypes = await getAllMediaTypes();
      //expect(mediaTypes.length).toBe(5);// this could fail if another test alters the mediatypes table        
      expect(mediaTypes.length).toBeGreaterThan(4);        
    });

    it('should return an array of Artist objects', async () => {
      const mediaTypes = await getAllMediaTypes();
      expect(mediaTypes[0].constructor.name).toBe("MediaType");

    });

  }) // end of getAllMediaTypes()
  
  
  describe("getMediaTypeById()", () => {

    it("should get the proper MediaType when a valid param is passed", async () => {
      const mediaType = await getMediaTypeById(1);
      expect(mediaType.name).toBe("MPEG audio file"); // Note: this could fail if another tests alters the first MediaType
    })

    it("should return null if there is no media type with the matching id", async () => {
      const mediaType = await getMediaTypeById(1111111111111);
      expect(mediaType).toBe(null);
    })

  }) // end of getMediaTypeById()

  
  describe("insertMediaType()", () => {

    it("The returned id should be greater than 0", async () => {
      const mediaTypeId = await insertMediaType(new MediaType({name:"Some new media type"}));
      expect(mediaTypeId).toBeGreaterThan(0)
    })

    it("should throw error if the parameter is not MediaType model object", async () => {
      // we expect the error message to include 'Invalid parameter'
      await expect(insertMediaType("BLAH")).rejects.toThrow(/Invalid parameter/);
    })
      
    it("should throw error if the MediaType parameter is not valid", async () => {
      // we expect the error message to include 'Invalid MediaType'
      await expect(insertMediaType(new MediaType({name:""}))).rejects.toThrow(/Invalid MediaType/);
    })

  }) // end of insertMediaType()
  
  
  describe("updateMediaType()", () => {

    it("should return true on successful update", async () => {
      // Beware: updating a media type in the test db could cause another test to fail (if it uses the same id)
      const result = await updateMediaType(new MediaType({id:2, name:"Test MediaType"}));
      expect(result).toBe(true);
    })

    it("should return false if there is no matching id", async () => {
      const result = await updateMediaType(new MediaType({id:1111111111, name:"BLAH"}));
      expect(result).toBe(false)
    })

    it("should throw error if the parameter is not an MediaType model object", async () => {
      // we expect the error message to include 'Invalid parameter'
      await expect(updateMediaType("BLAH")).rejects.toThrow(/Invalid parameter/);
    })
      
    it("should throw error if the MediaType parameter is not valid", async () => {
      // we expect the error message to include 'Invalid MediaType'
      await expect(updateMediaType(new MediaType({name:""}))).rejects.toThrow(/Invalid MediaType/);
    })

  }) // end of updateMediaType()
  
  
  describe("deleteMediaType()", () => {
                
    it("should return true on successful delete", async () => {
      const newMediaTypeId = await insertMediaType(new MediaType({name:"some new media type"}));
      const result = await deleteMediaType(newMediaTypeId);
      expect(result).toBe(true)
    })
    
    it("should return false if there is no matching id", async () => {
      const result = await deleteMediaType(11111111);
      expect(result).toBe(false)
    })
    
    it("should throw error if the delete violates a FK constraint", async () => {
      await expect(deleteMediaType(1)).rejects.toThrow(/FOREIGN KEY/);
    })
    
  }) // end of deleteMediaType()
  

}) // end of MediaType Data Service tests
