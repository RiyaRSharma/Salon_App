const sequelize = require('../config/db');

const getUserProfileByEmail = async (email) => {
  const result = await db.query('SELECT name, email, phone_number FROM users WHERE email = $1', [email]);
  return result.rows[0];
};

const getPastBookingsByEmail = async (email) => {
  const result = await db.query(
    'SELECT service, date FROM bookings WHERE user_email = $1 ORDER BY date DESC',
    [email]
  );
  return result.rows;
};

const getSavedSalonsByEmail = async (email) => {
  const result = await db.query(
    'SELECT salon_name FROM saved_salons WHERE user_email = $1',
    [email]
  );
  return result.rows;
};

module.exports = {
  getUserProfileByEmail,
  getPastBookingsByEmail,
  getSavedSalonsByEmail,
};
