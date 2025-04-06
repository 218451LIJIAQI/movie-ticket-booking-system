const express = require('express');
const path = require('path');
const cors = require('cors');
const db = require('./config/db');

// Import Routes
const userRoutes = require('./routes/userRoutes');
const movieRoutes = require('./routes/movieRoutes');
const bookingRoutes = require('./routes/bookingRoutes');
const adminRoutes = require('./routes/adminRoutes');
const typeRoutes = require('./routes/typeRoutes');
const promoRoutes = require('./routes/promoRoutes');

const app = express();
const port = process.env.PORT || 3001;

// Enable CORS
app.use(cors());

// Handle JSON requests
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Static Resource Proxy
app.use(express.static(path.join(__dirname, 'prototype UI', 'prototype file')));

// Serve main HTML file
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'prototype UI', 'prototype file', 'user.html'));
});

app.get('/admin', (req, res) => {
    res.sendFile(path.join(__dirname, 'prototype UI', 'prototype file', 'admin.html'));
});

// Use Route Module
app.use('/api/users', userRoutes);
app.use('/api/movies', movieRoutes);
app.use('/api/bookings', bookingRoutes);
app.use('/api/admin', adminRoutes);
app.use('/api/types', typeRoutes);
app.use('/api/promos', promoRoutes);

// Start the Server
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});