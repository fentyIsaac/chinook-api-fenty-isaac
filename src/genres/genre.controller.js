const{getAllGenres, getGenreById, insertGenre, updateGenre, deleteGenre} = require("./genre.data.service");
const Genre = require("./genre.model");

exports.getAllHandler = async(req, res, next) => {
  
  try{
    const allGenres = await getAllGenres();
    res.json(allGenres);
  }catch(err){
    next(err);
  }
};

exports.getIdHandler = async(req, res, next) => {
  
  try{
  const genre = await getGenreById(req.params.id);
  if(genre){
    res.status(200).json(genre);
  }else{
    res.status(404).json({message: "failed - resource not found"});
  }
  }catch(err){
    next(err);
  }
};

exports.insertHandler = async(req, res, next) => {
  
  try{
    const genre = new Genre(req.body);
    const [isValid, error] = genre.validate();
    if(isValid){
      genre.id = await insertGenre(genre);
      res.status(201).json(genre);
    }else{
      res.status(400).json({message: "failed - invalid genre", error});
    }
    
  }catch (err){
    next(err);
  }
};

exports.updateHandler = async(req, res, next) => {
 
  try{
    if(req.params.id == req.body.id){
      const genre = new Genre(req.body);
      const [isValid, err] = genre.validate();
      if(isValid){
        const result = await updateGenre(genre);
        if(result === true){
          res.status(200).json({message: "success"})
        }else{
          res.status(500).json({message: "failed to updated"})
        }
      }else{
        res.status(400).json({message: "failed - invalid", err})
      }
    }else{
      res.status(400).json({message: "failed id mismatch"});
    }
  }catch(err){
    next(err);
  }
};

exports.deleteHandler = async(req, res, next) => {
  
  try{
    const result = await deleteGenre(req.params.id);
    if(result === true){
      res.status(200).json({message: "success"});
    }else{
      res.status(400).json({message: "failed"});
    }
    
  }catch(err){
    next(err);
  }
};