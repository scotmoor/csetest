var path = require('path');

module.exports = {
  mongo: {
    dbUrl: 'https://api.mongolab.com/api/1',            // The base url of the MongoLab DB server
    apiKey: 'eW8yc-kM1OsiaGpjNglybUlhYZ9yPxeF'          // Our MongoLab API key
  },
  security: {
    dbName: 'DATABASE_NAME',                  // The name of database that contains the security information
    usersCollection: 'users'                            // The name of the collection contains user information
  },
  server: {
    listenPort: 3000,                                   // The port on which the server is to listen (means that the app is at http://loc$
    securePort: 8433,                                   // The HTTPS port on which the server is to listen (means that the app is at http$
    distFolder: path.resolve(__dirname, '../client/dist'),  // The folder that contains the application files (note that the files are in$
    staticUrl: '/static',                               // The base url from which we serve static files (such as js, css and images)
    cookieSecret: 'angular-app'                         // The secret for encrypting the cookie
  }
};
