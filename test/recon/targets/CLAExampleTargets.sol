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

    function invariant_performUpkeep() public asAdmin {
        (bool success,) = cla.checkUpkeep("");

        if(success){
            uint256 targetInitialBalance = cla.s_fundingTarget().balance;
            uint256 contractInitialBalance = address(cla).balance;

            cla.performUpkeep(bytes(""));

            //1. Should never transfer tokens to the target if he is above the minimum threshold
            //3. Contract balance should only decrease after a call to `topUp()` or `withdraw()`
            assert(targetInitialBalance < cla.s_fundingTarget().balance);
            assert(contractInitialBalance > address(cla).balance);

            cla.withdraw(cla.s_fundingTarget().balance, payable(address(this)));
        }
    }

    function invariant_withdraw(uint256 _amount, address payable _receiver) public asAdmin {
        
        if(_receiver == address(cla)) return;

        _amount = between(_amount, 1e10, type(uint256).max);

        uint256 contractInitialBalance = address(cla).balance;

        cla.withdraw(_amount, _receiver);
        
        // 2. The Admin should be able to withdraw any amount equal or lesser than the contract balance.
        gt(contractInitialBalance, address(cla).balance, "Balance have not decreased");
    }
}