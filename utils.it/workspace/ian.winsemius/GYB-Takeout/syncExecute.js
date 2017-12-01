const log = require('simple-node-logger').createSimpleLogger('execute.log');
const { exec, execSync } = require('child_process');
log.setLevel('info');

exports.async  = function(command){
	exec(command, (err, stdout, stderr) => {
	  if (err) {
	    log.fatal(new Date().toJSON(), ' - FATAL: ', err);
	    return;
	  } else if (stderr){
    log.error(new Date().toJSON(), ' - ERROR: ', stderr);
    }
    log.info(new Date().toJSON(), ' - INFO: ', stdout);
	});
}

exports.sync  = function(command){
  var result = execSync(command).toString();
  if(result !== ''){
    log.info(new Date().toJSON(), ' - SYNC-LOG: ', result)
  }
}