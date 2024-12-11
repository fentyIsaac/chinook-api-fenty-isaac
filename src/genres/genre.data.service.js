const { json } = require("express");
const pool = require("../db");
const Genre = require("./genre.model");

exports.getAllGenres = async () =>{
  const connection = await pool.getConnection();
  const sql = "SELECT GenreId, Name FROM genre";
  const [rows] = await connection.query(sql);
  
  const allGenres = rows.map(r => new Genre({id: r.GenreId, name: r.Name}));
  connection.release();
  return allGenres;
}

exports.getGenreById = async (id) =>{
  const connection = await pool.getConnection();
  const sql = "SELECT GenreId, Name FROM genre WHERE GenreId = ?";
  const [rows] = await connection.query(sql, [id]);
  let genre = null;
  if(rows.length === 1){
    genre = new Genre({id: rows[0].GenreId, name: rows[0].Name});
  }
  connection.release();
  return genre;
}

exports.insertGenre = async (genre) =>{
  
  if(genre.constructor.name != "Genre"){
    throw new Error("Invalid parameter sent to insertGenre() - must be a genre object");
  }
  
  const [isValid, errs] = genre.validate();

  if(isValid){
    const connection = await pool.getConnection();
    const sql = "INSERT INTO genre (Name) VALUES (?)";
    const [result] = await connection.query(sql, [genre.name]);
    connection.release();
    return result?.insertId;
  } else {
    throw new Error("Invalid Genre - " + JSON.stringify(errs));
  }
}

exports.updateGenre = async (genre) =>{
  if(genre.constructor.name != "Genre"){
    throw new Error("Invalid parameter sent to updateGenre() - must be a Genre model object")
  }

  const [isValid, errs] = genre.validate();

  if(isValid){
    const connection = await pool.getConnection();
    const sql = "UPDATE genre SET Name=? WHERE GenreId=?";
    const [result] = await connection.query(sql, [genre.name, genre.id]);
    connection.release();
    return result.affectedRows === 1 ? true : false;

  }else{
    throw new Error("Invalid Genre - " + JSON.stringify(errs));
  }
}

exports.deleteGenre = async (id) =>{
  try{
    const connection = await pool.getConnection();
    const sql = "DELETE FROM genre WHERE GenreId =?";
    const [result] = await connection.query(sql, [id]);
    connection.release();
    return result.affectedRows === 1 ? true : false;
  }catch(e){
    throw(e);
  }
}