//// backend/config/twilioConfig.js
//const twilio = require('twilio');
//
//const accountSid = process.env.TWILIO_ACCOUNT_SID; // Twilio Account SID
//const authToken = process.env.TWILIO_AUTH_TOKEN; // Twilio Auth Token
//const twilioPhoneNumber = process.env.TWILIO_PHONE_NUMBER; // Twilio Phone Number
//
//const client = twilio(accountSid, authToken);
//
//// Send WhatsApp message
//const sendWhatsAppMessage = async (phoneNumber, message) => {
//  try {
//    const response = await client.messages.create({
//      from: `whatsapp:${twilioPhoneNumber}`,
//      to: `whatsapp:${phoneNumber}`,
//      body: message,
//    });
//    console.log('✅ WhatsApp Message Sent:', response.sid);
//  } catch (error) {
//    console.error('❌ Error sending WhatsApp message:', error.message);
//    throw error;
//  }
//};
//
//module.exports = { sendWhatsAppMessage };
