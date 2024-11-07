const express = require('express');
const app = express();
const PORT = 3000;

app.use(express.urlencoded({ extended: true })) 
app.use(express.json()) 

app.get('/', (req, res) => {
    res.send('Dockerizing Node Application');
});

app.listen(PORT, function() {
    console.log(`The server is running on http://localhost:${PORT}`);
});
