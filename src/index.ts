import express from 'express'
import cors from 'cors'

const app = express()
app.use(express.json())
app.use(cors())

const PORT = 8800

app.listen(PORT, () => {
  console.log(`Dev server running at: http://0.0.0.0:${PORT}`)
})
