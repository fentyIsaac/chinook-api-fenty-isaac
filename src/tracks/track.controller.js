const { getAllTracks, getTrackById, insertTrack, updateTrack, deleteTrack } = require("./track.data.service");
const Track = require("./track.model");

exports.getAllHandler = async (req, res, next) => {
  try {
    const allTracks = await getAllTracks();
    res.json(allTracks);
  } catch (err) {
    next(err);
  }
};

exports.getByIdHandler = async (req, res, next) => {
  
  try {
    const track = await getTrackById(req.params.id);
    if (track) {
      res.status(200).json(track);
    } else {
      res.status(404).json({ message: "failed - resource not found" });
    }
  } catch (err) {
    next(err);
  }
};

exports.insertHandler = async (req, res, next) => {
  try {
  
    const newTrack = new Track(req.body);

   
    const [isValid, errors] = newTrack.validate();

    if (isValid) {
      const trackId = await insertTrack(newTrack);
      res.status(201).json({ id: trackId, ...newTrack });
    } else {
      res.status(400).json({ message: "failed - invalid" });
    }
  } catch (err) {
    next(err);
  }
};

exports.updateHandler = async (req, res, next) => {
  try {
    if (parseInt(req.params.id) === parseInt(req.body.id)) {
      
      const track = new Track(req.body);

      
      const [isValid, errors] = track.validate();

      
      if (isValid) {
        const result = await updateTrack(track);
        if (result === true) {
          res.status(200).json({ message: "success" });
        } else {
          res.status(400).json({ message: "failed to update" });
        }
      } else {
        res.status(400).json({ message: "failed - invalid", errors });
      }
    } else {
      res.status(400).json({ message: "failed - id mismatch" });
    }
  } catch (err) {
    
    next(err);
  }
};

exports.deleteHandler = async (req, res, next) => {
  try {
    const idToDelete = parseInt(req.params.id);  
    
    
    if (isNaN(idToDelete) || idToDelete <= 0) {
      return res.status(400).json({ message: "Invalid track ID" });
    }

    
    const result = await deleteTrack(idToDelete);
    
    if (result === true) {
      res.status(200).json({ message: "Track deleted successfully" });
    } else {
      res.status(400).json({ message: "Failed to delete track - track not found" });
    }
  } catch (err) {
    next(err);
  }
};
