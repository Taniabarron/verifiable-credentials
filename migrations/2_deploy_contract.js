var MyDapp = artifacts.require("VerificableCredentials");

module.exports = function(deployer){
    deployer.deploy(MyDapp,'0xEef56780cBa0A40196f42d329428202CDDdc0E4b');
}