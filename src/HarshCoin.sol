// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract HarshCoin is ERC20 {
    uint public number;

    constructor() ERC20("Harsh","HARSH"){
        
    }
    function mint(address to, uint256 amount) public {
        _mint(to, amount); 
    }
}