const AV = require('leanengine')
const fs = require('fs')
const path = require('path')

fs.readdirSync(path.join(__dirname, 'functions')).forEach(file => {
  require(path.join(__dirname, 'functions', file))
})

AV.Cloud.define('searchUserByUsername', function (request) {
  var query = new AV.Query('_User')
  return query
    .equalTo('username', request.params.username)
    .find()
    .then(res => {
      if (res.length == 0) {
        return 'empty'
      }
      return res[0]
    })
})

AV.Cloud.define('searchUserByUserId', function (request) {
  var query = new AV.Query('_User')
  return query
    .whereContainedIn('objectId', request.params.userIds).find()
})
