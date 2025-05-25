const twilio = require('twilio');
const accountSid = process.env.TWILIO_ACCOUNT_SID;
const authToken = process.env.TWILIO_AUTH_TOKEN;
const client = new twilio(accountSid, authToken);

exports.sendWhatsAppMessage = async (req, res) => {
  const { phone, message } = req.body;

  try {
    const msg = await client.messages.create({
      body: message,
      from: 'whatsapp:+14155238886', // Twilio WhatsApp Sandbox Number
      to: `whatsapp:${phone}` // User's WhatsApp Number
    });

    res.status(200).json({
      success: true,
      message: 'Message sent successfully!',
      data: msg.sid
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: error.message
    });
  }
};
