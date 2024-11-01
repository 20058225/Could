const express = require('express');
const app = express();

app.get('/', (req, res) => {
    res.send("Welcome to my app!");
});

app.listen(3000, function() {
    console.log("App listening on port 3000");
});
