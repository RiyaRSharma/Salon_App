const Review = require('../models/reviewModel');

// Get all reviews
exports.getReviews = async (req, res) => {
  try {
    const reviews = await Review.findAll();
    res.json(reviews);
  } catch (error) {
    res.status(500).send(error.message);
  }
};

// Get review by ID
exports.getReviewById = async (req, res) => {
  try {
    const review = await Review.findByPk(req.params.id);
    if (!review) {
      return res.status(404).send('Review not found');
    }
    res.json(review);
  } catch (error) {
    res.status(500).send(error.message);
  }
};

// Create a new review
exports.createReview = async (req, res) => {
  const { userId, salonId, rating, review_text } = req.body;

  if (!userId || !salonId || !rating || !review_text) {
    return res.status(400).send('All fields are required');
  }

  try {
    const newReview = await Review.create({
      userId,
      salonId,
      rating,
      review_text,
    });

    res.status(201).json(newReview);
  } catch (error) {
    res.status(500).send(error.message);
  }
};

// Update a review
exports.updateReview = async (req, res) => {
  try {
    const review = await Review.findByPk(req.params.id);
    if (!review) {
      return res.status(404).send('Review not found');
    }

    await review.update(req.body);
    res.json(review);
  } catch (error) {
    res.status(500).send(error.message);
  }
};

// Delete a review
exports.deleteReview = async (req, res) => {
  try {
    const review = await Review.findByPk(req.params.id);
    if (!review) {
      return res.status(404).send('Review not found');
    }

    await review.destroy();
    res.send('Review deleted successfully');
  } catch (error) {
    res.status(500).send(error.message);
  }
};
