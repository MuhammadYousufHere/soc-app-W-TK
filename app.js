/**
 * Project Name: Social
 * Description: A social networking platform with automated content moderation and context-based authentication system.
 *
 * Author: Muhammad Yousuf
 * Email: khanyousufmy80@gmail.com
 */

require('dotenv').config()
const express = require('express')
const adminRoutes = require('./server/routes/admin.route.js')
const userRoutes = require('./server/routes/user.route.js')
const postRoutes = require('./server/routes/post.route.js')
const communityRoutes = require('./server/routes/community.route.js')
const contextAuthRoutes = require('./server/routes/context-auth.route.js')
const search = require('./server/controllers/search.controller.js')
const Database = require('./server/config/database.js')
const decodeToken = require('./server/middlewares/auth/decodeToken.js')

const app = express()

const cors = require('cors')
const morgan = require('morgan')
const passport = require('passport')

const PORT = process.env.PORT || 4000

const db = new Database(process.env.MONGODB_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})

db.connect().catch((err) => console.error('Error connecting to database:', err))

app.use(cors())
app.use(morgan('dev'))
app.use('/assets/userFiles', express.static(__dirname + '/assets/userFiles'))
app.use(
  '/assets/userAvatars',
  express.static(__dirname + '/assets/userAvatars')
)

app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use(passport.initialize())
require('./server/config/passport.js')

app.get('/server-status', (req, res) => {
  res.status(200).json({ message: 'Server is up and running!' })
})

app.get('/search', decodeToken, search)

app.use('/auth', contextAuthRoutes)
app.use('/users', userRoutes)
app.use('/posts', postRoutes)
app.use('/communities', communityRoutes)
app.use('/admin', adminRoutes)

process.on('SIGINT', async () => {
  try {
    await db.disconnect()
    console.log('Disconnected from database.')
    process.exit(0)
  } catch (err) {
    console.error(err)
    process.exit(1)
  }
})

app.listen(PORT, () => console.log(`Server up and running on port ${PORT}!`))