// backend/routes/notificationRoutes.js

const express = require('express');
const router = express.Router();
const { sendWhatsAppMessage } = require('../controllers/notificationController');

// ✅ Route to send WhatsApp message using the controller directly
router.post('/send', sendWhatsAppMessage);

module.exports = router;
