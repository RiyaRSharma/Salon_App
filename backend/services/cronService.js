const cron = require('node-cron');
const twilioClient = require('./twilioService');
const Booking = require('../models/bookingModel');
const { Op } = require('sequelize');

const sendReminders = async () => {
  const now = new Date();
  const oneHourLater = new Date(now.getTime() + 60 * 60 * 1000); // 1 hour from now

  const upcomingBookings = await Booking.findAll({
    where: {
      bookingDate: {
        [Op.between]: [now, oneHourLater],
      },
      status: 'confirmed', // Optional: only send reminders for confirmed bookings
    },
  });

  for (const booking of upcomingBookings) {
    const message = `⏰ Reminder: Hello ${booking.userName}, your appointment at ${booking.salonName} is in 1 hour, scheduled for ${booking.bookingDate}. See you soon!`;
    await twilioClient.sendWhatsAppMessage(booking.phoneNumber, message);
  }

  console.log(`✅ Sent ${upcomingBookings.length} reminders.`);
};

// Run cron every 10 minutes
cron.schedule('*/10 * * * *', () => {
  console.log('⏰ Running reminder check...');
  sendReminders();
});

module.exports = { sendReminders };
