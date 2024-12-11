const { json } = require("express");
const pool = require("../db");
const Artist = require("./artist.model");

exports.getAllArtists = async () => {
  const connection = await pool.getConnection();
  const sql = "SELECT ArtistId, Name FROM artist";
  const [rows] = await connection.query(sql);
  const allArtist = rows.map(r => new Artist({id: r.ArtistId, name: r.Name}));
  connection.release();

  return  allArtist;
};

exports.getArtistById = async (id)=>{
  const connection = await pool.getConnection();
  const sql = "SELECT ArtistId, Name FROM artist WHERE ArtistId = ?";
  const [rows] = await connection.query(sql, [id]);
  let artist = null;
  if(rows.length === 1){
    artist = new Artist({id: rows[0].ArtistId, name: rows[0].Name});
  }
  connection.release();
  return artist;
};

exports.insertArtist = async (artist) => {
  if(artist.constructor.name != "Artist"){
    throw new Error("Invalid parameter sent to insertArtist() - must be a artist object ");
  }

  const [isValid, errs] = artist.validate();
  
  if(isValid){
  const connection = await pool.getConnection();
  const sql = "INSERT INTO artist (Name) VALUES (?)";
  const [result] = await connection.query(sql, [artist.name]);
  connection.release();
  return result.insertId;
  } else {
    throw new Error("Invalid Artist - " + JSON.stringify(errs));
  }
};

exports.updateArtist = async (artist) => {
  if(artist.constructor.name != "Artist"){
    throw new Error("Invalid parameter sent to updateArtist() - must be a artist object");
  }

  const [isValid, errs] = artist.validate();

  if(isValid){
    const connection = await pool.getConnection();
    const sql = "UPDATE artist SET Name=? WHERE ArtistId = ?";
    const [result] = await connection.query(sql, [artist.name, artist.id]);
    connection.release();
    return result.affectedRows === 1 ? true : false;
  }else{
    throw new Error("Invalid Artist - ", errs);
  }
};

exports.deleteArtist = async (id) => {
  try{
    const connection = await pool.getConnection();
    const sql = "DELETE FROM artist WHERE ArtistId = ?";
    const [result] = await connection.query(sql, [id]);
    connection.release();
    return result.affectedRows === 1 ? true : false;
  } catch(err){
    throw err;
  }
};