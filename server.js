const express = require('express');
const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
    res.send('Dockerizing Node Application');
});

app.listen(PORT, '0.0.0.0', function() {
    console.log(`The server is running on http://0.0.0.0:${PORT}`);
});