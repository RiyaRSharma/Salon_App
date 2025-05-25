const express = require('express');
const router = express.Router();
const profileController = require('../controllers/profileController');

router.get('/get-profile', profileController.getProfileData);

module.exports = router;
