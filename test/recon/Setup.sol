// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

// Chimera deps
import {BaseSetup} from "@chimera/BaseSetup.sol";
import {vm} from "@chimera/Hevm.sol";

// Managers
import {ActorManager} from "@recon/ActorManager.sol";
import {AssetManager} from "@recon/AssetManager.sol";

// Helpers
import {Utils} from "@recon/Utils.sol";

// Your deps
import "src/CLAExample.sol";

abstract contract Setup is BaseSetup, ActorManager, AssetManager, Utils {
    CLAExample cla;
    address constant TARGET = address(777);
    address constant FORWARDER = address(888);
    
    /// === Setup === ///
    /// This contains all calls to be performed in the tester constructor, both for Echidna and Foundry
    function setup() internal virtual override {
        cla = new CLAExample(
            TARGET,
            address(this)
        ); // TODO: Add parameters here

        vm.deal(address(cla), type(uint256).max);

        cla.setForwarderAddress(FORWARDER);
    }

    /// === MODIFIERS === ///
    /// Prank admin and actor
    
    modifier asAdmin {
        vm.prank(address(this));
        _;
    }

    modifier asActor {
        vm.prank(address(_getActor()));
        _;
    }
}
