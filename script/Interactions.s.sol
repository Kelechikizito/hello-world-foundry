// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {HelloWorld} from "src/HelloWorld.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract InteractionsScript is Script {
    address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("HelloWorld", block.chainid);

    function run() external {
        greetUser(mostRecentlyDeployed);
    }

    function greetUser(address contractAddress) public {
        vm.startBroadcast();
        HelloWorld(contractAddress).greet("Billionaire Kelechi Kizito Ugwu");
        vm.stopBroadcast();
    }
}
