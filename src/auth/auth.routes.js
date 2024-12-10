const express = require('express');
const router = express.Router();
const {loginHandler, logoutHandler, isLoggedIn} = require("./auth.controller")

router.post("/login", loginHandler);
router.get("/logout", logoutHandler);

router.get("/loginCheck", isLoggedIn,  (req, res, next) => {
  res.json({message: "Looks like your logged in!"})
})

module.exports = router;