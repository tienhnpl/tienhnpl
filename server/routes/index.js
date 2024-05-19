const useRouter = require('./Users')
const {notFound, errHandler}=require('../middlewares/errorHandler')

const initRouters=(app)=>{
    app.use('/api/user',useRouter)

    app.use(notFound)
    app.use(errHandler)
}
module.exports=initRouters