const express = require('express');
const router = express.Router();

const {getAllHandler, 
  getIdHandler, 
  deleteHandler, 
  insertHandler, 
  updateHandler
} = require("./media-type.controller");

router.get("/", getAllHandler);

router.post("/", insertHandler);

router.get("/:id", getIdHandler);

router.put("/:id", updateHandler);

router.delete("/:id", deleteHandler);

module.exports = router;