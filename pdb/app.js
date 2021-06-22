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

//app.use(express.json());

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

app.get('/loginDoc', (req,res) =>{
    res.render('loginDoc.ejs');
})


app.post('/loginDoc', async(req,res) => {
    try{

        const {id, password} = req.body;

        db.query("SELECT worker_id, `password` FROM doctor WHERE worker_id = ?",[id],(error,result) =>{
            if(error){
                console.log(error);
            } 

            console.log(result);
            var count = Object.keys(result).length;

            if(!count){
                res.send('WRONG ID OR PASSWORD! <p><a href="/loginDoc"> Login Doctor</a></p>');
            } 

            if(count == 1){
                res.redirect("/doctor");
            } else {
                console.log(count);
            }

        })
    }catch(error){
        console.log(error);
    }
        
})

app.get("/doctor",(req, res) => {
    res.render("doctor.ejs");
})

app.get('/loginOff', (req,res) =>{
    res.render('loginOff.ejs');
})


app.post('/loginOff', async(req,res) => {
    try{

        const {id, password} = req.body;

        db.query("SELECT worker_id, `password` FROM officer WHERE worker_id = ?",[id],(error,result) =>{
            if(error){
                console.log(error);
            } 

            console.log(result);
            var count = Object.keys(result).length;

            if(!count){
                res.send('WRONG ID OR PASSWORD! <p><a href="/loginOff"> Login Officer</a></p>');
            } 

            if(count == 1){
                res.redirect("/officer");
            } else {
                console.log(count);
            }

        })
    }catch(error){
        console.log(error);
    }
        
})

app.get('/officer', (req,res) => {
    res.render("officer.ejs");
})

app.get('/officer/prisonAdd', (req, res) => {
    res.render("prisonAdd.ejs");
})

app.post('/officer/prisonAdd', (req,res) => {
    console.log(req.body);

    const prison_id = req.body.prison_id;
    const ward_id = req.body.ward_id;
    const tc = req.body.tc;
    const name = req.body.name;
    const birth_date = req.body.bdate;
    const phone = req.body.phone;
    const country = req.body.country;
    const arrest_date = req.body.adate;
    const release_date = req.body.rdate;

    res.send(name + " added successfully" +"\n" 
        +'<p><a href="/officer">Return Officer Page</a></p>');
})

