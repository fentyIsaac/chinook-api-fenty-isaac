const { json } = require("express");
const pool = require("../db");
const Album = require("./album.model");


exports.getAllAlbums = async () => {
  const connection = await pool.getConnection();
  const sql = `
    SELECT album.albumId, album.artistId, album.title, artist.name AS artist
    FROM album
    JOIN artist ON album.artistId = artist.artistId`; 
  const [rows] = await connection.query(sql);

  const allAlbums = rows.map(r => new Album({
    id: r.albumId,
    title: r.title,
    artistId: r.artistId,
    artist: r.artist 
  }));
  connection.release();
  return allAlbums;
};

exports.getAlbumById = async (id) => {
  const connection = await pool.getConnection();
  const sql = `
    SELECT album.albumId, album.artistId, album.title, artist.name AS artist
    FROM album
    JOIN artist ON album.artistId = artist.artistId
    WHERE album.albumId = ?`; 
  const [rows] = await connection.query(sql, [id]);
  let album = null;

  if (rows.length === 1) {
    album = new Album({
      id: rows[0].albumId,
      title: rows[0].title,
      artistId: rows[0].artistId,
      artist: rows[0].artist 
    });
  }
  connection.release();
  return album;
};


exports.insertAlbum = async(album)=>{
  if(album.constructor.name !== "Album"){
    throw new Error("Invalid parameter sent to insertAlbum() - Must be an album object");
  }
  
  const [isValid, errs] = album.validate();

  if(isValid){
    const connection = await pool.getConnection();
    const sql = "INSERT INTO album (title, artistId) VALUES (?, ?)";
    const [result] = await connection.query(sql, [album.title, album.artistId]);
    connection.release();

    return result.insertId;
  }else{
    throw new Error("Invalid Album - " + JSON.stringify(errs));
  }
};

exports.updateAlbum = async(album) =>{
  if(album.constructor.name !== "Album"){
    throw new Error("Invalid parameter");

  }

  const [isValid, errs] = album.validate();

  if(isValid){
    const connection = await pool.getConnection();
    const sql = "UPDATE album SET title = ?, artistId = ? WHERE albumId = ?";
    const [result] = await connection.query(sql, [album.title, album.artistId, album.id]);
    connection.release();

    if(result.affectedRows > 0){
      return true;

    } else{
      return false;
    }
  } else {
    throw new Error("Invalid Album - " + JSON.stringify(errs));
  }
}

exports.deleteAlbum = async(albumId)=>{
  if(typeof albumId !== "number"){
    throw new Error("Invalid parameter sent to deleteAlbum() - must be a number")
  }

  if(albumId <= 0){
    throw new Error("Invalid AlbumId - must be greater than 0");
  }

  const connection = await pool.getConnection();
  const sql = "DELETE FROM album WHERE albumId = ?";
  const [result] = await connection.query(sql, [albumId]);
  connection.release();

  if(result.affectedRows > 0){
    return true;
  }else{
    return false;
  }

  
}

exports.getValidArtistIds = async() => {
  const connection = await pool.getConnection();
  const sql = "SELECT ArtistId FROM artist";
  const [rows] = await connection.query(sql);
  connection.release();

  return rows.map((row) => row.ArtistId);
  
}