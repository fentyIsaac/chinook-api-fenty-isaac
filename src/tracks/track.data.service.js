const pool = require("../db");
const Track = require("./track.model");

exports.getAllTracks = async () => {
  // TODO: Run a query to get all rows 
  // TODO: Convert each row into a model object and add it to an array
  // TODO: Return the array 
  const connection = await pool.getConnection();
  try{
    const sql = "SELECT TrackId, Name, AlbumId, GenreId, MediaTypeId, Milliseconds, UnitPrice FROM track";
    const [rows] = await connection.query(sql);

    const tracks = rows.map(row => new Track({
      id: row.TrackId,
      name: row.Name, 
      albumId: row.AlbumId,
      genreId: row.GenreId,
      mediaTypeId: row.MediaTypeId,
      milliseconds: row.Milliseconds,
      unitPrice: row.UnitPrice,
    }));

    return tracks;
    
  } catch(err){
    console.error("Error:", err)
    throw err;
  } finally {
    connection.release();
  }
};

exports.getTrackById = async (id) => {
  // TODO: Run a query to get the row that matches the id parameter
  // TODO: Convert the row to a model object
  const connection = await pool.getConnection();
  try{
    const sql = `
        SELECT 
        t.TrackId, 
        t.Name, 
        t.AlbumId, 
        a.Title AS Album, 
        t.GenreId, 
        g.Name AS Genre, 
        t.MediaTypeId,
        mt.Name AS MediaType,
        t.Milliseconds, 
        t.UnitPrice
      FROM 
        track t
      LEFT JOIN 
        album a ON t.AlbumId = a.AlbumId
      LEFT JOIN 
        genre g ON t.GenreId = g.GenreId
      LEFT JOIN
        mediaType mt ON t.MediaTypeId = mt.MediaTypeId
      WHERE 
      t.TrackId = ?
      `;

    const [rows] = await connection.query(sql, [id]);
    let track = null;
    if(rows.length === 1){
      const row = rows[0];
        track =  new Track({
          id: row.TrackId,
          name: row.Name,
          albumId: row.AlbumId,
          album: row.Album, 
          genreId: row.GenreId,
          genre: row.Genre, 
          mediaTypeId: row.MediaTypeId,
          mediaType: row.MediaType,
          milliseconds: row.Milliseconds,
          price: parseFloat(row.UnitPrice) || 0.0,
      });
    }

    return track;
  } catch (err){
    console.error("Error:", err)
    throw err
  } finally {
    connection.release();
  }
};

exports.insertTrack = async (track) => {
  
  // make sure that the param is an instance of a track.model.js model object
  if(track.constructor.name !== "Track"){
    throw new Error("Invalid parameter sent to insertTrack() - must be a track model object")
  }

  // make sure the track.model.js param is valid
  const [isValid, errs] = track.validate()
  if(!isValid){
    throw new Error("Invalid Track - " + JSON.stringify(errs));
  }
  
    // TODO: Use the model properties to insert a row
    // TODO: Return the insert ID

  
      const connection = await pool.getConnection();
      try{
       const sql =`
        INSERT INTO track (\`Name\`, \`AlbumId\`, \`GenreId\`, \`MediaTypeId\`, \`Milliseconds\`, \`UnitPrice\`)
        VALUES (?, ?, ?, ?, ?, ?)
        `;

        const values = [
          track.name,
          track.albumId,
          track.genreId, 
          track.mediaTypeId,
          track.milliseconds,
          track.price
        ];
        

        const [result] = await connection.query(sql, values);

        return result.insertId;
      }catch (err){
        console.error("Error inserting track:", err);
        throw err;
      }finally{
        connection.release();
      }
    };

exports.updateTrack = async (track) => {
  // make sure that the param is an instance of a track.model.js model object
  if(track.constructor.name !== "Track"){
    throw new Error("Invalid parameter sent to updateTrack() - must be a Track model object")
  }

  // make sure the track.model.js param is valid
  const [isValid, errs] = track.validate()
  if(!isValid){
    throw new Error("Invalid Track - " + JSON.stringify(errs));
  }

  if(!track.id){
    throw new Error("Id is required for the update");
  }

  const connection = await pool.getConnection();

  try{


    const sql = `
      UPDATE track
      SET \`Name\` = ?, \`AlbumId\` = ?, \`GenreId\` = ?, \`MediaTypeId\` = ?, \`Milliseconds\` = ?, \`UnitPrice\` = ?
      WHERE \`TrackId\` = ?
    `;

    const values = [
      track.name,
      track.albumId,
      track.genreId,
      track.mediaTypeId,
      track.milliseconds,
      track.price,
      track.id
    ];

    

    const [result] = await connection.query(sql, values);

    if(result.affectedRows === 0){
      return false
    } else{
      return true;
    }
  } catch (err){
    console.error("Error updating track:", err);
    throw err
  } finally{
    connection.release();
  }

};


exports.deleteTrack = async (id) => {
  // TODO: Run the query to delete the row based on the id param
  // TODO: Return true if there is 1 affected row, otherwise return false

  if(!id){
    throw new Error("Id is required for the delete operation");
  }

  const connection = await pool.getConnection();

  try{
    const sql = `
    DELETE FROM track
    WHERE TrackId = ?
    
    `;

    const [result] = await connection.query(sql, [id]);

    if(result.affectedRows === 1){
      return true;

    }else{
      return false;
    }
  } catch (err){
    console.error("Error deleteing track: ", err);
    throw err
  } finally{
    connection.release();
  }
}
