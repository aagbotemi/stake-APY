// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./DogenToken.sol";

contract Stake is DegenToken {

    // deposit ETH into the token
    // there is an annual yield of 20% and paid out in ETH
    // after staking ETH recieve the exact amount in DEG to hold as placeholder
    // AFFTTTEEEERRRRR MAATTTUUUURRRRRIIIIIITTTTTTTYYYYYYYY
    // deposit the placeholder back into the contract
    // recieve your ETH back with the 20% yield

    
    struct StakeData {
        uint day;
        uint amount;
        uint year;
    }

    mapping (address=>StakeData) stakeRecord;

    function stake(uint _day) external payable {
        require(_day > 0, "Your staking should be more zero day");
        require(msg.value > 0, "You cannot stake zero amount");

        StakeData storage s = stakeRecord[msg.sender];

        s.amount += msg.value;
        s.day = ((1 minutes) * _day) + block.timestamp;
        s.year = 365 days + block.timestamp;


        mint(msg.value);
    }


    function withdrawStake() external {
        StakeData storage s = stakeRecord[msg.sender];
        uint _amount = s.amount;

        require(s.day < block.timestamp, "The token is not mature for withdrawal");
        require(s.amount < 0, "No money");


        uint yield = calculateYield(s.day, s.year, s.amount);

        uint transferrableYield = yield + _amount;

        s.amount = 0;
        s.year = 0;
        s.day = 0;

        _transfer(msg.sender, address(this), _amount);
        payable(msg.sender).transfer(transferrableYield);
    }

    function calculateYield(uint _day, uint _year, uint _amount) internal pure returns(uint) {
        return _day / _year * _amount;
    }


    function contractBalance() external view returns(uint) {
        return address(this).balance;
    }

    receive() external payable {}
    fallback() external payable {}
}




























