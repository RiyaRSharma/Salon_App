const Booking = require('../models/bookingModel');
const { sendBookingConfirmation } = require('../services/notificationService'); // Use central logic

// Get all bookings
exports.getBookings = async (req, res) => {
  try {
    const bookings = await Booking.findAll();
    res.json(bookings);
  } catch (error) {
    res.status(500).send(error.message);
  }
};

// Create a new booking and send confirmation via notificationService
exports.createBooking = async (req, res) => {
  try {
    const booking = await Booking.create(req.body);

    // Use centralized confirmation logic
    sendBookingConfirmation(booking); // 👈 Fire and forget

    res.status(201).json(booking);
  } catch (error) {
    console.error('❌ Booking creation failed:', error.message);
    res.status(500).send('Booking failed.');
  }
};
