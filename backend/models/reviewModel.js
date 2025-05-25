const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');
const User = require('./userModel');
const Salon = require('./salonModel');

const Review = sequelize.define('Review', {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  userId: {
    type: DataTypes.INTEGER,
    field: 'user_id',
    references: {
      model: User,
      key: 'id',
    },
  },
  salonId: {
    type: DataTypes.INTEGER,
    field: 'salon_id',
    references: {
      model: Salon,
      key: 'id',
    },
  },
  rating: {
    type: DataTypes.FLOAT,
    allowNull: false,
  },
  review_text: {
    type: DataTypes.TEXT,
    allowNull: false,
  },
  created_at: {
    type: DataTypes.DATE,
    defaultValue: DataTypes.NOW,
  }
}, {
  tableName: 'reviews',
  timestamps: false, // Disable Sequelize's automatic timestamps
});

module.exports = Review;
