const express = require("express");
require("dotenv").config();
const dbConnect = require('./config/dbConnect')
const initRouters = require('./routes')
const cookieParser = require('cookie-parser')

const app = express();
app.use(cookieParser())
const port = process.env.PORT || 8888;
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
dbConnect()
initRouters(app)

// app.use("/", (req, res) => {
//   res.send("server onnn");
// });
app.listen(port, () => {
  console.log("đã chạy thành công trên cổng", port);
});