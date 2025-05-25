// backend/routes/salonRoutes.js
const express = require('express');
const router = express.Router();
const salonController = require('../controllers/salonController');

router.get('/', salonController.getSalons);
router.get('/:id', salonController.getSalonById);
router.post('/', salonController.createSalon);
router.put('/:id', salonController.updateSalon);
router.delete('/:id', salonController.deleteSalon);

module.exports = router;
