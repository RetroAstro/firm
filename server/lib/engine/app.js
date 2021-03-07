'use strict';

var express = require('express');
var timeout = require('connect-timeout');
var path = require('path');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var AV = require('leanengine');

require('./cloud');

var app = express();

app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(timeout('15s'));

app.use(AV.express());

app.enable('trust proxy');

// app.use(AV.Cloud.HttpsRedirect());

app.use(express.static('public'));

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());

app.get('/', function (req, res) {
  res.render('index', { currentTime: new Date() });
});

app.use('/todos', require('./routes/todos'));

app.use(function (req, res, next) {
  if (!res.headersSent) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
  }
});

app.use(function (err, req, res, next) {
  if (req.timedout && req.headers.upgrade === 'websocket') {
    return;
  }

  var statusCode = err.status || 500;
  if (statusCode === 500) {
    console.error(err.stack || err);
  }
  if (req.timedout) {
    console.error('Request timeout: url=%s, timeout=%d.', req.originalUrl, err.timeout);
  }
  res.status(statusCode);
  var error = {};
  if (app.get('env') === 'development') {
    error = err;
  }
  res.render('error', {
    message: err.message,
    error: error
  });
});

module.exports = app;
