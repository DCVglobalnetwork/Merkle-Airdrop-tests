// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {BagelToken} from "../src/BagelToken.sol";

contract BagelTokenTest is Test {
    BagelToken token;
    address owner = address(0x123);
    address user = address(0x456);

    function setUp() public {
        vm.prank(owner); // Simulate owner as the contract deployer
        token = new BagelToken();
    }

    function testTokenMetadata() public view {
        assertEq(token.name(), "Bagel");
        assertEq(token.symbol(), "BAGEL");
    }

    function testOwnerIsSet() public view {
        // Check that the owner is correctly set
        assertEq(token.owner(), owner);
    }

    function testMint() public {
        uint256 mintAmount = 1000 * 10 ** 18; // BagelToken with 18 decimals
        uint256 initialBalance = token.balanceOf(user);

        vm.prank(owner); // Ensure only the owner can call the mint function
        token.mint(user, mintAmount);

        // Check the balance of the user after minting
        assertEq(token.balanceOf(user), initialBalance + mintAmount);
    }

    function testTotalSupplyAfterMint() public {
        uint256 mintAmount = 1000 * 10 ** 18;
        uint256 initialSupply = token.totalSupply();

        vm.prank(owner);
        token.mint(user, mintAmount);

        // Check that total supply has increased by the mint amount
        assertEq(token.totalSupply(), initialSupply + mintAmount);
    }

    function testTransfer() public {
        uint256 mintAmount = 1000 * 10 ** 18;
        address recipient = address(0x789);

        vm.prank(owner);
        token.mint(user, mintAmount);

        // Simulate user transferring tokens to recipient
        vm.prank(user);
        token.transfer(recipient, mintAmount / 2);

        // Check balances after transfer
        assertEq(token.balanceOf(user), mintAmount / 2);
        assertEq(token.balanceOf(recipient), mintAmount / 2);
    }
}
