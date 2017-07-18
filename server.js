var express = require('express'),
  bodyParser = require('body-parser'),
  mongoose = require('mongoose'),
  port = 8000,
  app = express();
app.use(bodyParser.urlencoded({extended: true}));
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');
mongoose.connect('mongodb://localhost/bucketlist');

var Schema = mongoose.Schema;

var BucketlistSchema = new mongoose.Schema({
  objective: { type: String, required: [true, 'objective required'], minlength: 2 }
}, { timestamps: true });

var Bucketlist = mongoose.model('bucketlist', BucketlistSchema);

app.get('/', function(req, res){
  Bucketlist.find(function(err, data){
    if(err) {console.log(err);}
    res.render('index', {tasks: data})
  }).sort({'createdAt': -1})
})
app.get('/tasks', function(req, res){
  res.render('new');
})
app.post('/tasks', function(req, res){
  Bucketlist.create(req.body, function(err, data){
    if(err) {console.log(err);}
    console.log(req.body);
    res.redirect('/');
  })
})
app.listen(port, function() {
  console.log('running on', port);
})
