const express = require('express');
const app = express();

app.use(express.urlencoded({ extended: true })) 
app.use(express.json()) 

app.get('/', (req, res) => {
    res.send('Dockerizing Node Application');
});

app.listen(3000, function() {
    console.log("App listening on port 3000");
});
