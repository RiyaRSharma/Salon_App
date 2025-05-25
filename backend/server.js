const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const sequelize = require('./config/db');
const cron = require('node-cron');
const { sendReminder } = require('./services/notificationService');

// Import route files
const userRoutes = require('./routes/userRoutes');
const bookingRoutes = require('./routes/bookingRoutes');
const salonRoutes = require('./routes/salonRoutes');
const reviewRoutes = require('./routes/reviewRoutes');
const offerRoutes = require('./routes/offerRoutes');
const notificationRoutes = require('./routes/notificationRoutes');
const profileRoutes = require('./routes/profileRoutes'); // ✅ ADDED

const app = express();

// ✅ Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// ✅ Route middleware
app.use('/api/users', userRoutes);
app.use('/api/bookings', bookingRoutes);
app.use('/api/salons', salonRoutes);
app.use('/api/reviews', reviewRoutes);
app.use('/api/offers', offerRoutes);
app.use('/api/notification', notificationRoutes);
app.use('/api/profile', profileRoutes); // ✅ ADDED

// ✅ Test route
app.get('/', (req, res) => {
  res.send('API is running...');
});

// ✅ Cron Job
cron.schedule('0 * * * *', async () => {
  console.log('⏰ Checking for upcoming bookings...');
  await sendReminder();
});

// ✅ Database sync
sequelize
  .sync()
  .then(() => {
    console.log('✅ Database synced');
  })
  .catch((err) => {
    console.log('❌ Error:', err);
  });

// ✅ Server start
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`🚀 Server running on http://localhost:${PORT}`);
});
