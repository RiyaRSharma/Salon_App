// backend/controllers/offerController.js
const Offer = require('../models/offerModel');

// Get all offers
exports.getOffers = async (req, res) => {
  try {
    const offers = await Offer.findAll();
    res.json(offers);
  } catch (error) {
    res.status(500).send(error.message);
  }
};

// Get offer by ID
exports.getOfferById = async (req, res) => {
  try {
    const offer = await Offer.findByPk(req.params.id);
    if (!offer) {
      return res.status(404).send('Offer not found');
    }
    res.json(offer);
  } catch (error) {
    res.status(500).send(error.message);
  }
};

// Create a new offer
exports.createOffer = async (req, res) => {
  try {
    const offer = await Offer.create(req.body);
    res.status(201).json(offer);
  } catch (error) {
    res.status(500).send(error.message);
  }
};

// Update offer
exports.updateOffer = async (req, res) => {
  try {
    const offer = await Offer.findByPk(req.params.id);
    if (!offer) {
      return res.status(404).send('Offer not found');
    }
    await offer.update(req.body);
    res.json(offer);
  } catch (error) {
    res.status(500).send(error.message);
  }
};

// Delete offer
exports.deleteOffer = async (req, res) => {
  try {
    const offer = await Offer.findByPk(req.params.id);
    if (!offer) {
      return res.status(404).send('Offer not found');
    }
    await offer.destroy();
    res.send('Offer deleted successfully');
  } catch (error) {
    res.status(500).send(error.message);
  }
};
