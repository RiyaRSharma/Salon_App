const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');
const Salon = require('./salonModel');

const Offer = sequelize.define('Offer', {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  salonId: {
    type: DataTypes.INTEGER,
    references: {
      model: Salon,
      key: 'id',
    },
  },
  offerDetails: {
    type: DataTypes.TEXT,
  },
  expiryDate: {
    type: DataTypes.DATE,
  },
},
{
    tableName: 'offers', // ✅ Match with your table name
    timestamps: false, // Optional, if you don't need createdAt/updatedAt
  }
);

module.exports = Offer;
