const fs = require('fs')
const path = require('path')

fs.readdirSync(path.join(__dirname, 'functions')).forEach(file => {
  require(path.join(__dirname, 'functions', file))
})
