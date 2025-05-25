// backend/controllers/bookingController.js
const Booking = require('../models/bookingModel');
const { sendWhatsAppMessage } = require('../services/twilioService'); // ✅ Importing the Twilio message sender

// Get all bookings
exports.getBookings = async (req, res) => {
  try {
    const bookings = await Booking.findAll();
    res.json(bookings);
  } catch (error) {
    res.status(500).send(error.message);
  }
};

// Create a new booking and send WhatsApp confirmation
exports.createBooking = async (req, res) => {
  try {
      console.log("Incoming booking request body:", req.body); // ✅ Log the request data
    const booking = await Booking.create(req.body);

    // ✅ Construct WhatsApp confirmation message
    const message = `Hi ${booking.userName}, your booking at ${booking.salonName} is confirmed for ${booking.bookingDate}.`;

    // ✅ Trigger WhatsApp message (non-blocking)
    sendWhatsAppMessage(booking.phoneNumber, message);

    res.status(201).json(booking);
  } catch (error) {
    console.error('❌ Booking creation failed:', error.message);
    res.status(500).send('Booking failed.');
  }
};
