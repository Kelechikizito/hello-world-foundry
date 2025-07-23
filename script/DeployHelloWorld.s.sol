// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {HelloWorld} from "src/HelloWorld.sol";

contract DeployHelloWorld is Script {
    function run() external returns (HelloWorld) {
        HelloWorld helloWorld = deployHelloWorld();
        return helloWorld;
    }

    function deployHelloWorld() public returns (HelloWorld) {
        vm.startBroadcast();
        HelloWorld helloWorld = new HelloWorld("Hello");
        vm.stopBroadcast();
        return helloWorld;
    }
}
