require('dotenv').config()
const express = require('express');
const axios = require('axios');

const PORT = 5000

const app = express();

app.use('/:carrier/:tracking', (req, res) => {
  const carrier = req.params['carrier'];
  const tracking = req.params['tracking'];

  axios({
    method: 'get',
    url: `https://api.aftership.com/v4/trackings/${carrier}/${tracking}`,
    headers: {'aftership-api-key': `${process.env.AFTERSHIP_KEY}`}
  })
  .then((response) => res.send(response.data["data"]["tracking"]))
  .catch((error) => {
    if (error.response) {
      res.send(error.response.status);
    }
  })
})

app.listen(PORT, () => console.log(`Server started on PORT ${PORT}`));