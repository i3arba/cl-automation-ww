//SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

///@notice Foundry Stuff
import { Script, console } from "forge-std/Script.sol";

///@notice Contracts to be deployed
import { CLAExample } from "src/CLAExample.sol";

/**
    *@title Core Deploy Script
    *@notice Deployer contract for the protocol core
*/
contract DeployScript is Script {

    /**
        *@dev This function is required in Scripts
        *@notice You can change this simple struct to add params for example the deployment on test files and cli
        *@notice By doing that, you will be changing the function signature.
        *@notice So, you will need to update the signature to call on the CLI
    */
    function run() external returns(CLAExample cla_){
        address owner = address(0);
        address target = address(0);

        ///@notice foundry tool to deploy the contract
        vm.startBroadcast();
        
        cla_ = new CLAExample(target, owner);

        vm.stopBroadcast();

    }
}