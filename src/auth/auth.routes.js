const express = require('express');
const router = express.Router();
const {loginHandler, logoutHandler} = require("./auth.controller")

router.post("/login", loginHandler);
router.get("/logout", logoutHandler);

module.exports = router;
