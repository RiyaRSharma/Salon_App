const User = require('./userModel.js');     // Correct with .js
const Salon = require('./salonModel.js');
const Booking = require('./bookingModel.js');
const Review = require('./reviewModel.js');
const Offer = require('./offerModel.js');

// Define Relationships
User.hasMany(Booking, { foreignKey: 'userId' });
Booking.belongsTo(User, { foreignKey: 'userId' });

Salon.hasMany(Booking, { foreignKey: 'salonId' });
Booking.belongsTo(Salon, { foreignKey: 'salonId' });

User.hasMany(Review, { foreignKey: 'userId' });
Review.belongsTo(User, { foreignKey: 'userId' });

Salon.hasMany(Review, { foreignKey: 'salonId' });
Review.belongsTo(Salon, { foreignKey: 'salonId' });

module.exports = {
  User,
  Salon,
  Booking,
  Review,
  Offer,
};
