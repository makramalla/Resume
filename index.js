var static = require('node-static');
var http = require('http');
var log4js = require('log4js');

var port = 4000;
var file = new static.Server('./dist', {
    cache: 3600,
    gzip: true
});

var logger = log4js.getLogger();

function interrupt() {
  logger.info("Caught interrupt signal");
  process.exit();
}

process.on('SIGINT', interrupt);
process.on('SIGTERM', interrupt);

// serve
http.createServer(function (request, response) {
    request.addListener('end', function () {
        file.serve(request, response);
        logger.info(request.method, request.url)
    }).resume();
}).listen(port);

logger.info("Listening to 0.0.0.0:"+port);
