const User = require("../models/user");
const asyncHandler = require("express-async-handler");
const {generateAccessToken,generateRefreshToken} = require('../middlewares/jwt')

const register = asyncHandler(async (req, res) => {
  const { firstname, lastname, email, mobile, password } = req.body;
  if (!firstname || !lastname || !email || !mobile || !password) {
    return res.status(400).json({
      success: false,
      mes: "Missing inputs...",
    });
  }
  const user = await User.findOne({ email });
  if (user) throw new Error("Email has existed");
  else {
    const newUser = await User.create(req.body);
    return res.status(200).json({
      success: newUser ? true : false,
      mes: newUser ? "Register is successfully" : "Something is wrong",
    });
  }
});

const login = asyncHandler(async (req, res) => {
  const { firstname, lastname, email, mobile, password } = req.body;
  if (!email || !password) {
    return res.status(400).json({
      success: false,
      mes: "Missing inputs...",
    });
  }
  const response = await User.findOne({ email });
  if (response && await response.isCorrectPassword(password)){
    const {password, role, ...userData} = response.toObject()
    const accessToken = generateAccessToken(response._id,role)
    const refreshToken = generateRefreshToken(response._id)
    //lưu Token refresh vào database
    await User.findByIdAndUpdate(response._id, {refreshToken}, {new:true})
    //lưu token này vào cookies
    res.cookie('refreshToken', refreshToken, {httpsOnly:true, maxAge: 7*24*60*60*1000})
        return res.status(200).json({
            success: true,
            accessToken,
            userData
        })
  }
  else {
    throw new Error('Mật khẩu không chính xác!')
  }
});

const getCurrent = asyncHandler(async (req, res) => {
        const {_id} = req.user
        const user = await User.findById(_id).select('-refreshToken -password -role')
        return res.status(200).json({
            success: false,
            rs: user ? user : 'User not found'
        })
  });

module.exports = {
  register,
  login,
  getCurrent
};
