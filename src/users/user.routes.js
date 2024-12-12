// These are the updates to user.routes.js
// We are protecting each route with the isLoggedIn middleware function,
// which checks for a token sent in the Authorization header of the request

const express = require('express');
const router = express.Router();
const {
  getAllHandler, 
  insertHandler, 
  getByIdHandler, 
  updateHandler, 
  deleteHandler
} = require("./user.controller")

const {isLoggedIn} = require("../auth/auth.controller");

router.get("/", isLoggedIn, getAllHandler);

router.post("/", isLoggedIn, insertHandler);

router.get("/:id", isLoggedIn, getByIdHandler);

router.put("/:id", isLoggedIn, updateHandler);

router.delete("/:id", isLoggedIn, deleteHandler);

module.exports = router;
