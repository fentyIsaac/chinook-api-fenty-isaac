const express = require('express');
const helmet = require('helmet');
const cors = require('cors');
const app = express();

app.use(helmet());
app.use(express.json());




const corsOptions = {
   origin: 'http://localhost:5173', 
  optionsSuccessStatus: 200, 
  exposedHeaders: ['Authorization'], 
};

app.use(cors(corsOptions));

app.get('/', (req, res, next) => {
  res.json({ message: 'Hello, world!' });
});


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


app.use((err, req, res, next) => {
  
  const statusCode = err.statusCode ||  500;
  
  if(process.env.NODE_ENV == "production"){
    res.status(statusCode).json({message: "There has been an error!"});
  }else{
    
    res.status(statusCode).json({message: err.message, stacktrace: err.stack});
  }
});

module.exports = app;