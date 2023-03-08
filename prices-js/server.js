const express = require('express')
const app = express()
const port = 3000

const data = []

app.use(express.json())

app.get('/ping', (req, res) => {
  res.json({ status: 'ok' })
})

app.get('/prices', (req, res) => {
  res.json(data)
})

app.post('/prices', (req, res) => {
  res.json(data)
})

app.listen(port, () => {
  console.log(`App listening on port ${port}`)
})