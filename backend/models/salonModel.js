const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const Salon = sequelize.define(
  'Salon',
  {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true,
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    address: {
      type: DataTypes.STRING,
    },
    rating: {
      type: DataTypes.FLOAT,
      defaultValue: 0.0,
    },
    services: {
      type: DataTypes.STRING, // Comma-separated string
      allowNull: true,
    },
    offer: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    price: {
      type: DataTypes.FLOAT,
      allowNull: true,
    },
  },
  {
    tableName: 'salons',
    timestamps: false,
  }
);

module.exports = Salon;
