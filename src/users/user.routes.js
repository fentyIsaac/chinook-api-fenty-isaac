const express = require('express');
const router = express.Router();
const {
  getAllHandler, 
  insertHandler, 
  getByIdHandler, 
  updateHandler, 
  deleteHandler
} = require("./user.controller")

router.get("/", getAllHandler);

router.post("/", insertHandler);

router.get("/:id", getByIdHandler);

router.put("/:id", updateHandler);

router.delete("/:id", deleteHandler);

module.exports = router;
