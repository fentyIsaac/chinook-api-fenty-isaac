require('dotenv').config();
console.log("NODE_ENV: ", process.env.NODE_ENV);

const app = require('./app.js');

const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`);
});