// backend/controllers/salonController.js
const Salon = require('../models/salonModel');

// Get all salons
exports.getSalons = async (req, res) => {
  try {
    const salons = await Salon.findAll();
    res.json(salons);
  } catch (error) {
    res.status(500).send(error.message);
  }
};

// Get salon by ID
exports.getSalonById = async (req, res) => {
  try {
    const salon = await Salon.findByPk(req.params.id);
    if (!salon) {
      return res.status(404).send('Salon not found');
    }
    res.json(salon);
  } catch (error) {
    res.status(500).send(error.message);
  }
};

// Create a new salon
exports.createSalon = async (req, res) => {
  try {
    const salon = await Salon.create(req.body);
    res.status(201).json(salon);
  } catch (error) {
    res.status(500).send(error.message);
  }
};

// Update salon details
exports.updateSalon = async (req, res) => {
  try {
    const salon = await Salon.findByPk(req.params.id);
    if (!salon) {
      return res.status(404).send('Salon not found');
    }
    await salon.update(req.body);
    res.json(salon);
  } catch (error) {
    res.status(500).send(error.message);
  }
};

// Delete salon
exports.deleteSalon = async (req, res) => {
  try {
    const salon = await Salon.findByPk(req.params.id);
    if (!salon) {
      return res.status(404).send('Salon not found');
    }
    await salon.destroy();
    res.send('Salon deleted successfully');
  } catch (error) {
    res.status(500).send(error.message);
  }
};
