const CarbonCreditToken = artifacts.require("../contracts/CarbonCreditToken.sol");

module.exports = async function(deployer, network, accounts) {
    await deployer.deploy(CarbonCreditToken);
};
