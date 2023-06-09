const mysql = require("mysql2");
const express = require("express");
const xl = require('excel4node');
 
const app = express();
const urlencodedParser = express.urlencoded({extended: false});
app.use(express.static('public'));

const wb = new xl.Workbook();
const ws = wb.addWorksheet('Armies stats');

const headingColumnNames = [
  "segment",
  "planet",
  "control_by",
  "persent",
]

const pool = mysql.createPool({
  connectionLimit: 5,
  host: "localhost",
  user: "user",
  database: "db",
  password: "password"
});
 
app.set("view engine", "hbs");
var exec = require('child_process').execFile;
current_id = 0;

// получение списка пользователей
app.get("/", function(req, res){
    pool.query("SELECT * FROM Players", function(err, data) {
      if(err) return console.log(err);
      res.render("index.hbs", {
          users: data
      });
    });
});
app.get("/check",function(req,res){
  res.render("check.hbs");
});
app.post("/check",urlencodedParser,function(req,res)
{
  if(!req.body) return res.sendStatus(400);
  let _i = 0;
  const name = req.body.name;
  const password = req.body.password;
  const id = req.params.id;
  pool.query("SELECT * FROM Players", function(err, data) {
    if(err) return console.log(err);
    for(let i=0; i < data.length; i++){
      if(name == data[i].name && password == data[i].user_password)
      {
        current_id = data[i].id
        res.redirect("/armies");
      }
      else _i++;
    }
    if(_i == data.length){res.redirect("/inputError");}
  });
});
app.get("/inputError",function(req,res){
  res.render("inputError.hbs")
})
// возвращаем форму для добавления данных
app.get("/create", function(req, res){
    res.render("create.hbs");
});
// получаем отправленные данные и добавляем их в БД 
app.post("/create", urlencodedParser, function (req, res) {
    if(!req.body) return res.sendStatus(400);
    const name = req.body.name;
    const password = req.body.password;
    const fraction = req.body.fraction;
    pool.query("INSERT INTO Players (name, user_password,fraction) VALUES (?,?,?)", [name, password,fraction], function(err, data) {
      if(err) return console.log(err);
      res.redirect("/");
    });
});
app.get("/edit/:id", function(req, res){
  const id = req.params.id;
  pool.query("SELECT * FROM Players WHERE id=?", [id], function(err, data) {
    if(err) return console.log(err);
     res.render("edit.hbs", {
        user: data[0]
    });
  });
});
// получаем отредактированные данные и отправляем их в БД
app.post("/edit", urlencodedParser, function (req, res) {
         
  if(!req.body) return res.sendStatus(400);
  const name = req.body.name;
  const password = req.body.password;
  const fraction = req.body.fraction;
  const id = req.body.id;
  pool.query("UPDATE Players SET name=?, user_password=?,fraction=? WHERE id=?", [name, password,fraction, id], function(err, data) {
    if(err) return console.log(err);
    res.redirect("/");
  });
});
 
// получаем id удаляемого пользователя и удаляем его из бд
app.post("/delete/:id", function(req, res){
  const id = req.params.id;
  pool.query("DELETE FROM Players WHERE id=?", [id], function(err, data) {
    if(err) return console.log(err);
    res.redirect("/");
  });
});
app.get("/armies", function(req, res){
  pool.query("SELECT * FROM Armies WHERE user_id=?",[current_id], function(err, data) {
    if(err) return console.log(err);
    res.render("armies.hbs", {
      army: data
    });
  });
});
app.get("/edit_army/:id", function(req, res){
  const id = req.params.id;
  pool.query("SELECT * FROM Armies WHERE army_id=?", [id], function(err, data) {
    if(err) return console.log(err);
    res.render("edit_army.hbs", {
      army: data[0]
  });
  });
});

app.post("/launch_doc",function(req,res){
  exec('doc.bat', function(err, data) {                       
}); 
});

app.post("/battlegrounds/create_xlsx/:id",function(req,res){
  const id = req.params.id;
  pool.query("SELECT segment,planet,control_by,persent FROM Battlegrounds WHERE id=?",[id], function(err, data) {
    if(err) return console.log(err);
    let headingColumnIndex = 1;
    headingColumnNames.forEach(heading => {
        ws.cell(1, headingColumnIndex++)
            .string(heading)
    });
    let rowIndex = 2;
    data.forEach( record => {
    let columnIndex = 1;
    Object.keys(record).forEach(columnName =>{
      if(typeof record [columnName] == "string")
        ws.cell(rowIndex,columnIndex++)
            .string(record [columnName])
            if(typeof record [columnName] == "number")
        ws.cell(rowIndex,columnIndex++)
            .number(record [columnName])
    });
    rowIndex++;
}); 
    wb.write('army_data.xlsx');
    exec('table.bat', function(err, data) {                       
    }); 
  });
});

app.post("/edit_army", urlencodedParser, function (req, res) {
  if(!req.body) return res.sendStatus(400);
  const id = req.body.id;
  const army_name = req.body.army_name;
  const faction = req.body.faction;
  const num_units = req.body.num_units;
  const points_total = req.body.points_total;
  pool.query("UPDATE Armies SET army_name=?, faction=?, num_units=?, points_total=? WHERE army_id=?", [army_name, faction, num_units,points_total,id], function(err, data) {
    if(err) return console.log(err);
    res.redirect("/armies");
  });
});

app.post("/delete_army/:id", function(req, res){
  const id = req.params.id;
  pool.query("DELETE FROM Armies WHERE army_id=?", [id], function(err, data) {
    if(err) return console.log(err);
    res.redirect("/armies");
  });
});
app.get("/view_army/:id", function(req, res){
  const id = req.params.id;
  pool.query("SELECT * FROM Armies WHERE army_id=?", [id], function(err, data) {
    if(err) return console.log(err);
    res.render("view_army.hbs", {
      army: data[0]
  });
  });
});

app.get("/create_army", function(req, res){
  res.render("create_army.hbs");
});
// получаем отправленные данные и добавляем их в БД 
app.post("/create_army", urlencodedParser, function (req, res) {
  if(!req.body) return res.sendStatus(400);
  const army_name = req.body.army_name;
  const faction = req.body.faction;
  const num_units = req.body.num_units;
  const points_total = req.body.points_total;
  pool.query("INSERT INTO Armies (user_id, army_name, faction, num_units,points_total) VALUES (?,?,?,?,?)", [current_id,army_name, faction,num_units,points_total], function(err, data) {
    if(err) return console.log(err);
    res.redirect("/armies");
  });
});
app.post("/sort_armies", function(req, res){
  pool.query("SELECT * FROM Armies WHERE user_id=? ORDER BY army_name",[current_id], function(err, data) {
    if(err) return console.log(err);
    res.render("armies.hbs", {
      army: data
    });
  });
});
app.post("/find_army",urlencodedParser,function(req,res)
{
  if(!req.body) return res.sendStatus(400);
  let _i = 0;
  const name = req.body.needble_name;
  const id = req.params.id;
  pool.query("SELECT * FROM Armies WHERE user_id =?",[current_id], function(err, data) {
    if(err) return console.log(err);
    for(let i=0; i < data.length; i++){
      if(name == data[i].army_name)
      {
        res.render("view_army.hbs", {
          army: data[i]
      });
      }
      else _i++;
    }
    if(_i == data.length){res.redirect("/inputError");}
  });
});
app.get('/compound/:id', function(req, res){
  const id = req.params.id;
  pool.query("SELECT * FROM Armies_compound WHERE id_army=?", [id], function(err, data) {
    if(err) return console.log(err);
    res.render("compounds.hbs", {
      compounds: data
  });
  });
});
app.get("/heroes/:id", function(req, res){
  const id = req.params.id;
  pool.query("SELECT * FROM Heroes WHERE army_id=?", [id], function(err, data) {
    if(err) return console.log(err);
    res.render("heroes.hbs", {
      heroes: data
  });
  });
});
app.get("/battlegrounds/:id", function(req, res){
  const id = req.params.id;
  pool.query("SELECT * FROM Battlegrounds WHERE army_id=?", [id], function(err, data) {
    if(err) return console.log(err);
    res.render("battlegrounds.hbs", {
      battlegrounds: data
  });
  });
});
app.listen(3000, function(){
  console.log("Сервер ожидает подключения...");
});