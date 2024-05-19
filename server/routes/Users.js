const router=require('express').Router()
const ctrls=require('../controllers/Users')

router.post('/register',ctrls.register)
module.exports = router