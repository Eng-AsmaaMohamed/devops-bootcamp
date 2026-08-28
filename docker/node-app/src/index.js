const express = require('express');
const mongoose = require('mongoose');

const app = express();

const port = process.env.PORT || 4000;

mongoose.connect('mongodb://mongodb:27017/mydb') // mongodb://serviceName:port/databaseName
  .then(() => console.log('Connected to MongoDB'))
  .catch((err) => console.log('MongoDB connection error:', err));

app.get('/', (req, res) => {
  res.send('Hello from my Node.js app! hi');
});

app.listen(port, () => {
  console.log(`app is running with hot reload on ${port}`);
});
