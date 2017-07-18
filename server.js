var express = require('express'),
  bodyParser = require('body-parser'),
  mongoose = require('mongoose'),
  port = 8000,
  app = express();
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json())
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');
mongoose.connect('mongodb://localhost/bucketlist');

var Schema = mongoose.Schema;

var BucketlistSchema = new mongoose.Schema({
  objective: { type: String, required: [true, 'objective required'], minlength: 2 }
}, { timestamps: true });

var Bucketlist = mongoose.model('bucketlist', BucketlistSchema);

// Show all tasks
app.get('/tasks', function(req, res){
  Bucketlist.find(function(err, data){
    if(err) {console.log(err);}
    res.send(data)
  }).sort({'createdAt': -1})
})
// Create
app.post('/tasks', function(req, res){
  Bucketlist.create(req.body, function(err, data){
    if(err) {console.log(err);}
    res.redirect('/tasks');
  })
})
// Update
app.post('/tasks/:id', function(req, res){
  Bucketlist.update({_id: req.params.id}, req.body, function(err, data){
    if(err) {console.log(err);}
    console.log("ID:", req.params.id);
    console.log("REQ BODY:", req.body);
    res.redirect('/tasks')
  })
})
app.listen(port, function() {
  console.log('running on', port);
})
