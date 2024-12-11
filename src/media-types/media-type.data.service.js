const pool = require ("../db");
const MediaType = require ("./media-type.model");


exports.getAllMediaTypes = async () => {
  const connection = await pool.getConnection();
  const sql = "SELECT MediaTypeId, Name FROM mediatype ";
  const [rows] = await connection.query(sql);
  const allMediaTypes = rows.map(r => new MediaType({id: r.MediaTypeId, name: r.Name}));

  connection.release();
  return allMediaTypes;
};

exports.getMediaTypeById = async (id) => {
  const connection = await pool.getConnection();
  const sql = "SELECT MediaTypeId, Name FROM mediatype WHERE MediaTypeId = ?";
  const [rows] = await connection.query(sql, [id]);
  let mediaType = null;
  if(rows.length === 1){
    mediaType = new MediaType({id: rows[0].MediaTypeId, name: rows[0].Name});
  }
  connection.release();
  return mediaType;
};


exports.insertMediaType = async (mediaType) =>{
  // make sure param is proper data type
  if(mediaType.constructor.name != "MediaType"){
    throw new Error("Invalid parameter sent to insertMediaType() - must be a mediaType object");
  }
  // make sure the genre is valid
  const [isValid, errs] = mediaType.validate();

  if(isValid){
    const connection = await pool.getConnection();
    const sql = "INSERT INTO mediaType (Name) VALUES (?)";
    const [result] = await connection.query(sql, [mediaType.name]);
    connection.release();
    return result?.insertId;
  } else {
    throw new Error("Invalid MediaType - " + JSON.stringify(errs));
  }
};

exports.updateMediaType = async (mediaType) =>{
  if(mediaType.constructor.name != "MediaType"){
    throw new Error("Invalid parameter sent to updateMediaType() - must be a mediaType  object")
  }

  const [isValid, errs] = mediaType.validate();

  if(isValid){
    const connection = await pool.getConnection();
    const sql = "UPDATE mediaType SET Name=? WHERE MediaTypeId=?";
    const [result] = await connection.query(sql, [mediaType.name, mediaType.id]);
    connection.release();
    return result.affectedRows === 1 ? true : false;

  }else{
    throw new Error("Invalid MediaType - " + JSON.stringify(errs));
  }
};

exports.deleteMediaType = async (id) =>{
  try{
    const connection = await pool.getConnection();
    const sql = "DELETE FROM mediaType WHERE MediaTypeId =?";
    const [result] = await connection.query(sql, [id]);
    connection.release();
    return result.affectedRows === 1 ? true : false;
  }catch(e){
    throw(e);
  }
}
