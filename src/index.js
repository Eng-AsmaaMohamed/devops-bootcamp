const express = require('express');
const mongoose = require('mongoose');

const app = express();

const port = process.env.PORT || 4000;

// Connect to MongoDB using the Docker Compose service name.
// Format: mongodb://serviceName:port/databaseName
mongoose.connect('mongodb://mongodb:27017/mydb') 
  .then(() => console.log('Connected to MongoDB'))
  .catch((err) => console.log('MongoDB connection error:', err));

  // Basic route to test that the Node.js application is runnin
app.get('/', (req, res) => {
  res.send('Hello from my Node.js app! hi');
});

// Start the Node.js server on the configured port
app.listen(port, () => {
  console.log(`app is running with hot reload on ${port}`);
});
