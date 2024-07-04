const { default: mongoose } = require('mongoose');

const dbConnection = async () => {
    try {
        const conn = await mongoose.connect(process.env.MONGODB_URL);
        if (conn.connection.readyState === 1) {
            console.log('Đã kết nối thành công với MongoDB');
        } else {
            console.log('Kết nối MongoDB thất bại');
        }
    } catch (error) {
        console.error('Lỗi khi kết nối đến MongoDB:', error);
        throw new Error(error.message);
    }
};

module.exports = dbConnection;