// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DegenToken is ERC20 {

    constructor() ERC20("DegenToken", "DEG") {}

    function mint(uint _amount) internal {
        _mint(msg.sender, _amount);
    }

}