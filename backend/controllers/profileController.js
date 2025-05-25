const profileModel = require('../models/profileModel');

const getProfileData = async (req, res) => {
  try {
    const { email } = req.query;

    if (!email) {
      return res.status(400).json({ error: 'Email is required' });
    }

    const profile = await profileModel.getUserProfileByEmail(email);
    const pastBookings = await profileModel.getPastBookingsByEmail(email);
    const savedSalons = await profileModel.getSavedSalonsByEmail(email);

    return res.status(200).json({
      profile,
      pastBookings,
      savedSalons,
    });
  } catch (error) {
    console.error('Error fetching profile:', error.message);
    return res.status(500).json({ error: 'Internal server error' });
  }
};

module.exports = {
  getProfileData,
};
