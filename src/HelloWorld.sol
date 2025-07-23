// SPDX-License-Identifier: MIT

// Layout of the contract file:
// version
// imports
// interfaces, libraries, contract
// errors

// Inside Contract:
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private

// view & pure functions

pragma solidity ^0.8.26;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title HelloWorld
 * @author Billionaire Kelechi Kizito Ugwu
 * @notice A simple contract to demonstrate greeting functionality with a customizable prefix.
 * @dev This contract allows the owner to set a prefix for greetings and provides a function to
 * generate a greeting message. It inherits from OpenZeppelin's Ownable contract to manage ownership
 * and restrict certain functions to the owner.
 */
contract HelloWorld is Ownable {
    ////////////////////////
    //   State Variables  //
    ////////////////////////
    string private prefix;

    ////////////////////////
    //   Events           //
    ////////////////////////
    event PrefixChanged(string oldPrefix, string newPrefix);

    ////////////////////////
    //   Constructor      //
    ////////////////////////
    constructor(string memory _initialPrefix) Ownable(msg.sender) {
        prefix = _initialPrefix;
    }

    ///////////////////////////////
    //  External Functions       //
    ///////////////////////////////
    /**
     * @notice Sets a new prefix for greetings.
     * @param newPrefix The new prefix to set.
     */
    function setPrefix(string calldata newPrefix) external onlyOwner {
        string memory oldPrefix = prefix;
        prefix = newPrefix;
        emit PrefixChanged(oldPrefix, newPrefix);
    }

    ///////////////////////////////////////////
    //   Public & External View Functions   //
    //////////////////////////////////////////
    /**
     * @notice Generates a greeting message with the current prefix.
     * @param name The name to include in the greeting.
     * @return A greeting message combining the prefix and the provided name.
     */
    function greet(string calldata name) external view returns (string memory) {
        return string.concat(prefix, " ", name, "!");
    }

    function getPrefix() external view returns (string memory) {
        return prefix;
    }
}
