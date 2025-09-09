// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../contracts/SimpleBank.sol";

contract SimpleBankTest is Test {
    SimpleBank public bank;
    address user = address(1);

    function setUp() public {
        bank = new SimpleBank();
        vm.deal(user, 10 ether);
    }

    // Foundry will fuzz `depositAmount`
    function testFuzz_Deposit(uint256 depositAmount) public {
        vm.assume(depositAmount > 0 && depositAmount < 10 ether);
        vm.startPrank(user);
        bank.deposit{value: depositAmount}();
        assertEq(bank.balances(user), depositAmount);
        vm.stopPrank();
    }

    // Deposit then fuzz withdraw
    function testFuzz_Withdraw(uint256 depositAmount, uint256 withdrawAmount) public {
        vm.assume(depositAmount > 0 && depositAmount < 10 ether);
        vm.assume(withdrawAmount <= depositAmount);
        vm.startPrank(user);
        bank.deposit{value: depositAmount}();
        bank.withdraw(withdrawAmount);
        assertEq(bank.balances(user), depositAmount - withdrawAmount);
        vm.stopPrank();
    }
}
