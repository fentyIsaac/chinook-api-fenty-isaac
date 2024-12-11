const {getAllArtists, getArtistById, insertArtist, updateArtist, deleteArtist} = require("./artist.data.service");
const Artist = require("./artist.model");

exports.getAllHandler = async (req, res, next) => {
  try{
    const allartists = await getAllArtists();
    res.json(allartists);
  }catch(err){
    next(err);
  }
}

exports.getIdHandler = async (req, res, next) => {
  try{
    const artist = await getArtistById(req.params.id);
    if(artist){
      res.status(200).json(artist);
    }else{
      res.status(404).json({message:"failed - resource not found"});
    }
  }catch(err){
    next(err);
  }
}

exports.insertHandler = async (req, res, next) => {
  try{
   
    const artist = new Artist(req.body);

    
    const [isValid, errors] = artist.validate();

    if(isValid){
      artist.id = await insertArtist(artist);
      res.status(201).json(artist);
    }else{
      res.status(400).json({message:"failed - invalid"});
    }

  }catch(err){
    next(err);
  }
}

exports.updateHandler = async (req, res, next) => {
  try{
    if(req.params.id == req.body.id){

      
      const artist = new Artist(req.body);

      // validate the model
      const [isValid, errors] = artist.validate();

      if(isValid){
        const result = await updateArtist(artist);
        if(result === true){
          res.status(200).json({message:"success"});
        }else{
          res.status(400).json({message:"failed to update"});
        }
      }else{
        res.status(400).json({message:"failed - invalid"});
      }

    }else{
      res.status(400).json({message:"failed - id mismatch"});
    }
  }catch(err){
    next(err);
  }
}

exports.deleteHandler = async (req, res, next) => {
  try{
    const result = await deleteArtist(req.params.id);
    if(result === true){
      res.status(200).json({message:"success"}); 
    }else{
      res.status(400).json({message:"failed"});
    }
  }catch(err){
    next(err);
  }
}
