// Imports from other packages
const express = require('express');
const mongoose = require('mongoose');
const Stripe = require('stripe');

// Imports from other files
const authRouter = require('./routes/auth');
const adminRouter = require('./routes/admin');
const productRouter = require('./routes/product');
const userRouter = require('./routes/user');


const key = "pk_test_51PfxZsRwVDyQNNF8liXyiUxQ534BeO7HowngPUl5Ix1sJBPbawf29r094mmQz2FsVNl9yQ4lSFaQS3z48hzpGKMz00etIx9tqF";
const stripe = new Stripe(key);


// Initialization
const PORT = 3000;
const app = express();
const DB = "mongodb+srv://zahid:King.112@cluster0.dwfoc9f.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"

// Middleware

app.use(express.json()); // Middleware to parse JSON requests
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);


//connections 
mongoose.connect(DB).then(() => {
    console.log("connection successful");

}).catch((e) => {
    console.log(e);
});

// Routes
app.get('/', (req, res) => {
    res.json({ name: 'Zahid' });
});

// Starting the server
app.listen(PORT, "0.0.0.0", () => {
    console.log(`Server is running on port ${PORT}`);
});
