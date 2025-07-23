// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test} from "forge-std/Test.sol";
import {HelloWorld} from "src/HelloWorld.sol";
import {DeployHelloWorld} from "script/DeployHelloWorld.s.sol";

contract HelloWorldTest is Test {
    HelloWorld helloWorld;
    DeployHelloWorld deployer;

    function setUp() public {
        deployer = new DeployHelloWorld();
        helloWorld = deployer.run();
    }

    function testGreet() public view {
        // ARRANGE
        string memory expectedGreeting = "Hello Billionaire Kelechi Kizito Ugwu!";
        string memory actualGreeting = helloWorld.greet("Billionaire Kelechi Kizito Ugwu");

        // ASSERT
        assertEq(keccak256(abi.encodePacked(expectedGreeting)), keccak256(abi.encodePacked(actualGreeting)));
    }

    function testGetPrefix() public view {
        // ARRANGE
        string memory expectedPrefix = "Hello";
        string memory actualPrefix = helloWorld.getPrefix();

        // ASSERT
        assertEq(keccak256(abi.encodePacked(expectedPrefix)), keccak256(abi.encodePacked(actualPrefix)));
    }

    function testSetPrefix() public {
        // ARRANGE
        string memory newPrefix = "Bonjour";

        // ACT
        vm.prank(helloWorld.owner());
        helloWorld.setPrefix(newPrefix);

        // ASSERT
        string memory updatedPrefix = helloWorld.getPrefix();
        assertEq(keccak256(abi.encodePacked(newPrefix)), keccak256(abi.encodePacked(updatedPrefix)));
    }
}
