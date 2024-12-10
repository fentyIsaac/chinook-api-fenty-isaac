const express = require('express');
const app = express();

app.use(express.json());

app.get('/', (req, res, next) => {
  res.json({ message: 'Hello, world!' });
});

// ADD ROUTES HERE
app.use("/genres", require("./genres/genre.routes"));

app.use("/users", require("./users/user.routes"));

app.use("/albums", require("./albums/album.routes"));
app.use("/artists", require("./artists/artist.routes"));

app.use("/tracks", require("./tracks/track.routes"));

app.use("/media-types", require("./media-types/media-type.routes"));

app.use("/auth", require("./auth/auth.routes"));



app.all("*", (req, res, next) => {
  const err = new Error("Resource not found");
  err.statusCode = 404;
  next(err);
})

// ERROR HANDLER
app.use((err, req, res, next) => {
  
  const statusCode = err.statusCode ||  500;
  
  if(process.env.NODE_ENV == "production"){
    res.status(statusCode).json({message: "There has been an error!"});
  }else{
    //console.log("STATUS CODE: " + statusCode);
    //console.log("ERROR", err);
    res.status(statusCode).json({message: err.message, stacktrace: err.stack});
  }
});

module.exports = app;