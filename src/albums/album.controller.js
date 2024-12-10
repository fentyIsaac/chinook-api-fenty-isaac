const {getAllAlbums, getAlbumById, insertAlbum, updateAlbum, deleteAlbum, getValidArtistIds} = require('./album.data.service');
const Album = require('./album.model');

exports.getAllHandler = async(req, res, next) => {
  //res.json({"message": "get all genres"})
  try{
    const allAlbums = await getAllAlbums();
    res.json(allAlbums);
  }catch(err){
    next(err);
  }
};

exports.getIdHandler = async(req, res, next) => {
  //res.json({"message": "get genre with id of " + req.params.id})

  try{
  const album = await getAlbumById(req.params.id);
  if(album){
    res.status(200).json(album);
  }else{
    res.status(404).json({message: "failed - resource not found"});
  }
  }catch(err){
    next(err);
  }
};





exports.insertHandler = async (req, res, next) => {
  try {
    const { title, artistId } = req.body;
  
    let validArtistIds;
    try {
      validArtistIds = await getValidArtistIds();
    } catch (err) {
      return res.status(500).json({ message: "Error fetching valid artist IDs" });
    }

    
    if (!validArtistIds.includes(artistId)) {
      return res.status(400).json({ message: "Invalid artistId" });
    }

    const album = new Album({ title, artistId });
    const [isValid, error] = album.validate();

    if (isValid) {
      let albumId;
      try {
        albumId = await insertAlbum(album);
      } catch (err) {
        return res.status(500).json({ message: "Error inserting album" });
      }
      
      album.id = albumId; 
      res.status(201).json(album); 
    } else {
      return res.status(400).json({ message: "Failed - invalid album", error });

    }
  } catch (err) {
    next(err); 
  }
};


exports.updateHandler = async(req, res, next) => {
  //res.json({"message": "update genre with id of " + req.params.id})
  try {
    if (req.params.id == req.body.id) {
      const album = new Album(req.body);  // Fixed variable name from 'genre' to 'album'
      const [isValid, err] = album.validate();  // Use 'album' here
      if (isValid) {
        const result = await updateAlbum(album);
        if (result === true) {
          res.status(200).json({ message: "Album updated successfully" });
        } else {
          res.status(500).json({ message: "Failed to update album" });
        }
      } else {
        res.status(400).json({ message: "Invalid album data", error: err });  // More detailed error message
      }
    } else {
      res.status(400).json({ message: "ID mismatch between URL and body" });
    }
  } catch (err) {
    next(err);
  }

};

exports.deleteHandler = async(req, res, next) => {
  //res.json({"message": "delete genre with id of " + req.params.id})
  try {
    // Ensure the albumId is a number
    const albumId = Number(req.params.id);

    // Validate if the albumId is a valid number
    if (isNaN(albumId) || albumId <= 0) {
      return res.status(400).json({ message: "Invalid album ID. Must be a positive number." });
    }

    // Proceed to delete the album
    const result = await deleteAlbum(albumId);

    if (result) {
      res.status(200).json({ message: `Album with ID ${albumId} deleted successfully` });
    } else {
      res.status(404).json({ message: `Album with ID ${albumId} not found` });
    }
  } catch (err) {
    next(err);
  }
};