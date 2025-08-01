// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {BeforeAfter} from "../BeforeAfter.sol";
import {Properties} from "../Properties.sol";
// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

import "src/CLAExample.sol";

abstract contract CLAExampleTargets is
    BaseTargetFunctions,
    Properties
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///


    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function cLAExample_performUpkeep(address _newForwarderAddress) public asActor {
        (bool success,) = cla.checkUpkeep("");

        if(success){
            cla.setForwarderAddress(_newForwarderAddress);

            cla.performUpkeep(bytes(""));
        }
    }

    function cLAExample_setForwarderAddress(address _forwarderAddress) public asAdmin {
        cla.setForwarderAddress(_forwarderAddress);
    }

    function cLAExample_setFundingTarget(address _fundingTarget) public asAdmin {
        cla.setFundingTarget(_fundingTarget);
    }

    function cLAExample_withdraw(uint256 _amount, address payable _receiver) public asAdmin {
        cla.withdraw(_amount, _receiver);
    }
}