const express = require("express");
require("dotenv").config();

const app = express();
const port = process.env.PORT || 8888;
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use("/", (req, res) => {
  res.send("server onnn");
});
app.listen(port, () => {
  console.log("đã chạy thành công trên cổng", port);
});