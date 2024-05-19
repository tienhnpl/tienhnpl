const mongoose = require('mongoose');

const dbConnect = async () => {
  try {
    const conn = await mongoose.connect(process.env.MONGODB_URI);
    if (conn.connection.readyState === 1) {
      console.log("DB connected successfully");
    } else {
      console.log("DB connection failed");
    }
  } catch (error) {
    console.error("DB connection error:", error.message);
    process.exit(1); // Dừng chương trình khi kết nối DB thất bại
  }
};

module.exports = dbConnect;
