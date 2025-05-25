const twilio = require('twilio');
const accountSid = process.env.TWILIO_ACCOUNT_SID;
const authToken = process.env.TWILIO_AUTH_TOKEN;
const client = new twilio(accountSid, authToken);

// Send WhatsApp Message
const sendWhatsAppMessage = async (to, message) => {
  try {
    const response = await client.messages.create({
      from: 'whatsapp:+14155238886', // Twilio Sandbox Number
      to: `whatsapp:${to}`,
      body: message,
    });
    console.log('✅ WhatsApp message sent:', response.sid);
  } catch (error) {
    console.error('❌ Error sending WhatsApp message:', error);
  }
};

module.exports = { sendWhatsAppMessage };
