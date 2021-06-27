const express = require ("express");
const router = express.Router(); 
const authController = require ("../controllers/auth");

router.post('/login', (req, res) => {
    console.log(req.body);

    res.send({"message": "done"});
});

module.exports = router;