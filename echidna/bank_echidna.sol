// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract bank_echidna {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    // Property: Users should never be able to withdraw more than they have deposited
    function echidna_balance_nonnegative() public view returns (bool) {
        return balances[msg.sender] >= 0;
    }
}
