const {getAllMediaTypes, getMediaTypeById, insertMediaType, updateMediaType, deleteMediaType,} = require("./media-type.data.service")
const MediaType = require("./media-type.model");

exports.getAllHandler = async(req, res, next) => {
  //res.json({"message": "get all genres"})
  try{
    const allMediaTypes = await getAllMediaTypes();
    res.json(allMediaTypes);
  }catch(err){
    next(err);
  }
};

exports.getIdHandler = async(req, res, next) => {
  //res.json({"message": "get genre with id of " + req.params.id})

  try{
  const mediaType = await getMediaTypeById(req.params.id);
  if(mediaType){
    res.status(200).json(mediaType);
  }else{
    res.status(404).json({message: "failed - resource not found"});
  }
  }catch(err){
    next(err);
  }
};

exports.insertHandler = async(req, res, next) => {
  //res.json({"message": "insert genres"})
  try{
    const mediaType = new MediaType(req.body);
    const [isValid, error] = mediaType.validate();
    if(isValid){
      mediaType.id = await insertMediaType(mediaType);
      res.status(201).json(mediaType);
    }else{
      res.status(400).json({message: "failed - invalid mediaType", error});
    }
    
  }catch (err){
    next(err);
  }
};

exports.updateHandler = async(req, res, next) => {
  //res.json({"message": "update genre with id of " + req.params.id})
  try{
    if(req.params.id == req.body.id){
      const mediaType = new MediaType(req.body);
      const [isValid, err] = mediaType.validate();
      if(isValid){
        const result = await updateMediaType(mediaType);
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
  //res.json({"message": "delete genre with id of " + req.params.id})
  try{
    const result = await deleteMediaType(req.params.id);
    if(result === true){
      res.status(200).json({message: "success"});
    }else{
      res.status(400).json({message: "failed"});
    }
    
  }catch(err){
    next(err);
  }
};