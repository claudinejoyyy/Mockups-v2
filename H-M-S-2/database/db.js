var mysql = require('mysql');

var connection = mysql.createConnection({
host:'127.0.0.1',
user:'root',
password:'',
database:'hms',
    multipleStatements: true
});
connection.connect();

module.exports = connection;
