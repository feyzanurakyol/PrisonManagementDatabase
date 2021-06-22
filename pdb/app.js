const express = require("express");
var ejs = require('ejs');
const path = require("path");
const { nextTick } = require("process");
const exp = require("constants");
const mysql = require("mysql"); 

//Express app
const app = express();

const publicDirectory = path.join(__dirname,"./public");
app.use(express.static(publicDirectory));


//database starting
const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "password",
    database: "prisondatabase"
})


//db connection
db.connect((err,res) =>{
    if(err){
        console.log(err);
    } else {
        console.log(res);
    }
})

//register view engine
app.set('view engine', 'ejs');
app.use(express.urlencoded({extended: true}))

//listen for request
app.listen(3000)

/*app.use((req, res) => {
    console.log("new request made");
    console.log("host: ", req.hostname);
    console.log("path: ", req.path);
    console.log("method: ", req.method);
    next();
})*/

//GET requests
app.get('/', (req,res) =>{
    res.render('index.ejs', {root: __dirname});

})

app.get('/login', (req,res) =>{
    res.render('login.ejs');
})

app.post('/login', (req,res) => {
    console.log(req.body);
})

