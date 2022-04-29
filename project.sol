// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
// Sol Test

//My project. A Butcher Shop.  
contract ButcherMarket {

    // State variables
    address public owner;//Owner
    bool marketIsOpen;//Business is open or closed depending on this. 
    
    //Slices of meat offered.

    //Beef
    mapping (address => uint) ribeyeStock;
    mapping (address => uint) filetStock;
    mapping (address => uint) flankStock;
    mapping (address => uint) newYorkStripStock;
    mapping (address => uint) cow;

    //Picnic cuts
    mapping (address => uint) pepperoniStock;
    mapping (address => uint) salamiStock;


    // On creation...
    constructor () {
        // Set the owner as the contract's deployer
        owner = msg.sender;

        // Set initial flower stocks
        ribeyeStock[address(this)]  = 500;
        filetStock[address(this)]   = 100;
        flankStock[address(this)]  = 1500;
        newYorkStripStock[address(this)] = 1000;
        
        // Whole cow
        cow[address(this)] = 0;

        // Picnic cuts 
        pepperoniStock[address(this)] = 2000;
        salamiStock[address(this)] = 2500;

        // The shop is initially closed
        marketIsOpen = true;
    }

    // Function to compare two strings
    function compareStrings(string memory a, string memory b) private pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked(b)));
    }

    // Let the owner restock the shop
    function restock(uint amount, string memory meatCut) public {
        // Only the owner can restock!
        require(msg.sender == owner, "Only the owner can restock the machine!");

        // Refill the stock based on the type passed in
        if (compareStrings(meatCut, "ribeye")) {
            ribeyeStock[address(this)] += amount;
        } else if (compareStrings(meatCut, "filet")) {
            filetStock[address(this)] += amount;
        } else if (compareStrings(meatCut, "flank")) {
            flankStock[address(this)] += amount;
        } else if (compareStrings(meatCut, "strip")) {
            newYorkStripStock[address(this)] += amount;
        } else if (compareStrings(meatCut, "pepperoni")){
            pepperoniStock[address(this)] += amount;
        }
        else if (compareStrings(meatCut, "salami")){
            salamiStock[address(this)] += amount;
        }
        
        else if (compareStrings(meatCut, "all")) {
            ribeyeStock[address(this)] += amount;
            filetStock[address(this)] += amount;
            flankStock[address(this)] += amount;
            newYorkStripStock[address(this)] += amount;
            pepperoniStock[address(this)] += amount;
            salamiStock[address(this)] += amount;
        }
    }

    // Let the owner open and close the shop
    function openOrCloseShop() public returns (string memory) {
        if (marketIsOpen) {
            marketIsOpen = false;
            return "Butcher market is currently closed. Please return later.";
        } else {
            marketIsOpen = true;
            return "Butcher market is open.";
        }
    }

    // Purchase a meat from the butcher
    function purchase(uint amount, string memory meatCut) public payable {
        require(marketIsOpen == true, "The market is closed and you may not purchase meat.");
        require(msg.value >= amount * 1 ether, "You must pay at least 1 ETH per cut of meat!");

        // Sell a meat slice based on type asked
        if (compareStrings(meatCut, "ribeye")) {
            ribeyeStock[address(this)] -= amount;
            ribeyeStock[msg.sender] += amount;
        } else if (compareStrings(meatCut, "filet")) {
            filetStock[address(this)] -= amount;
            filetStock[msg.sender] += amount;
        } else if (compareStrings(meatCut, "flank")) {
            flankStock[address(this)] -= amount;
            flankStock[msg.sender] += amount;
        } else if (compareStrings(meatCut, "strip")) {
            newYorkStripStock[address(this)] -= amount;
            newYorkStripStock[msg.sender] += amount;
        } else if (compareStrings(meatCut, "pepperoni")){
            pepperoniStock[address(this)] -= amount;
            pepperoniStock[msg.sender] += amount;
        } 
        else if (compareStrings(meatCut, "salami")){
            salamiStock[address(this)] += amount;
            salamiStock[msg.sender] += amount;
        }
        
        else if (compareStrings(meatCut, "cow")) {
            ribeyeStock[address(this)] -= amount;
            filetStock[address(this)] -= amount;
            flankStock[address(this)] -= amount;
            newYorkStripStock[address(this)] -= amount;

            cow[msg.sender] += amount;
        }
    }

    // Get stock of a specific type of meat
    function getStock(string memory meatCut) public view returns (uint) {
        // Get stock of a meat based on the type passed in
        if (compareStrings(meatCut, "ribeye")) {
            return ribeyeStock[address(this)];
        } else if (compareStrings(meatCut, "filet")) {
            return filetStock[address(this)];
        } else if (compareStrings(meatCut, "flank")) {
            return flankStock[address(this)];
        } else if (compareStrings(meatCut, "strip")) {
            return newYorkStripStock[address(this)];
        } else if (compareStrings(meatCut, "pepperoni")) {
            return pepperoniStock[address(this)];
        } else if (compareStrings(meatCut, "salamiStock")){
            return salamiStock[address(this)];
        }
        else {
            return 0;
        }
    }
}
