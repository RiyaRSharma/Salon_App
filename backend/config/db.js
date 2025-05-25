// backend/config/db.js
const { Sequelize } = require('sequelize');

// Configure your database
const sequelize = new Sequelize('salon_app', 'postgres', 'Riya@30', {
  host: 'localhost',
  dialect: 'postgres',
  port: 5432, // Default port
});

// Test the connection
sequelize
  .authenticate()
  .then(() => {
    console.log('✅ Database connected successfully!');
  })
  .catch((err) => {
    console.error('❌ Unable to connect to the database:', err);
  });

module.exports = sequelize;
