var request = require('supertest');


var app = require('../server.js')

 describe('GET /', function(done) {
   it('displays "Hello World!"', function(done) {
     // The line below is the core test of our app.
     request(app).get('/')
      .expect('Hello World!')
      .then(() => done())
      .catch(err => done(err));
   });
 });
  
 
