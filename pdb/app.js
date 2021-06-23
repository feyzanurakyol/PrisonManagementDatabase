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


//--------- LOGIN--------------

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

//-----OFFICER VIEWS-------

app.get("/officer/allPrisons", (req,res) => {
    db.query("SELECT * FROM prison", (error, data, result)=>{
        if(error){
            console.log(error);
        }

        res.render("prisonlist.ejs",{userData: data});
    })
})

app.get("/officer/doctorCapacity", (req,res) => {
    db.query("SELECT * FROM prisondatabase.doctorscapacity;", (error, data, result)=>{
        if(error){
            console.log(error);
        }

        res.render("doctorCapacity.ejs",{userData: data});
    })
})

app.get("/officer/seeJailersWard", (req,res) => {
    db.query("SELECT * FROM prisondatabase.jailers_ward;", (error, data, result)=>{
        if(error){
            console.log(error);
        }

        res.render("seeJailersWard.ejs",{userData: data});
    })
})

app.get("/officer/remainingDays", (req,res) => {
    db.query("SELECT * FROM prisondatabase.remainingdays;", (error, data, result)=>{
        if(error){
            console.log(error);
        }

        res.render("remainingDays.ejs",{userData: data});
    })
})

//----- OFFICER SEARCH -----
app.get("/officer/prisonSearch", (req,res) => {
    db.query("SELECT * FROM prisondatabase.remainingdays;", (error, data, result)=>{
        if(error){
            console.log(error);
        }

        res.render("prisonSearch.ejs",{userData: data});
    })
})


//------- OFFICER METHODS ----------

app.get('/officer/prisonAdd', (req, res) => {
    res.render("prisonAdd.ejs");
})

app.post('/officer/prisonAdd', (req,res) => {
    console.log(req.body);

    const {prison_id,ward_id, tc, name, birth_date, phone, country, arrest_date} = req.body;

    db.query("INSERT INTO prison VALUES ("+ parseInt(prison_id) +", "+ parseInt(ward_id) +", "+
    parseInt(tc)+ ", \""+ name +"\", \"" + birth_date +"\", " + parseInt(phone) +", \""+ country + "\", \""+
    arrest_date +"\", \"" + arrest_date + "\")" , (error,result) => {
            if(error){
                console.log(error);
                res.send('ERROR');
            } else {
                console.log(parseInt(prison_id));
                res.send(name + " added successfully" +"\n" 
                      +'<p><a href="/officer">Return Officer Page</a></p>');
            }
        })
})

app.get("/officer/prisonDelete", (req,res) => {
    res.render("prisonDelete.ejs");
})

app.post('/officer/prisonDelete', (req,res) => {
    console.log(req.body);

    db.query("DELETE FROM prison WHERE prison_id = " + parseInt(req.body.prison_id) , (error,result) => {
            if(error){
                console.log(+error);
                res.send('ERROR');
            } else {
                res.send(req.body.prison_id + " deleted successfully" +"\n" 
                      +'<p><a href="/officer">Return Officer Page</a></p>');
            }
        })
})




