var Migrations = artifacts.require("../contracts/Migrations.sol");

module.exports = async function(deployer) {
  await deployer.deploy(Migrations);
};
