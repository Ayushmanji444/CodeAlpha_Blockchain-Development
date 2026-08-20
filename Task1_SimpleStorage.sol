// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {
    int256 private value;

    constructor() {
        value = 0;
    }

    function increment() public {
        value += 1;
    }

    function decrement() public {
        value -= 1;
    }

    function getValue() public view returns (int256) {
        return value;
    }
}
