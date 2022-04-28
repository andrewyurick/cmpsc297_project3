// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
// Sol Test
contract HelloWorld {

    // State variables
    string helloMsg = "Hello, world!";

    // On creation...
    constructor () {
        // Do nothing for now, because we don't need to
    }

    // Print hello world
    function sayHello() public view returns (string memory) {
        return helloMsg;
    }
}
