// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../script/DeployMerkleAirdrop.s.sol";
import "../src/MerkleAirdrop.sol";
import "../src/BagelToken.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DeployMerkleAirdropTest is Test {
    DeployMerkleAirdrop deployer;
    BagelToken bagelToken;
    MerkleAirdrop airdrop;
    uint256 constant AMOUNT_TO_TRANSFER = 4 * (25 * 1e18);

    function setUp() public {
        deployer = new DeployMerkleAirdrop();
    }

    function testDeployMerkleAirdrop() public {
        (airdrop, bagelToken) = deployer.deployMerkleAirdrop();

        // Check if the BagelToken contract is deployed and has a positive total supply
        assertTrue(address(bagelToken) != address(0), "BagelToken not deployed");
        assertTrue(bagelToken.totalSupply() > 0, "BagelToken totalSupply is zero");

        // Check if the MerkleAirdrop contract is deployed
        assertTrue(address(airdrop) != address(0), "MerkleAirdrop not deployed");

        // Verify the token transfer to the MerkleAirdrop contract
        uint256 balance = bagelToken.balanceOf(address(airdrop));
        assertEq(balance, AMOUNT_TO_TRANSFER, "Incorrect token balance in MerkleAirdrop");

        // Verify that the BagelToken contract owner is correctly set
        address owner = bagelToken.owner();
        assertTrue(owner != address(0), "BagelToken owner is zero address");
    }

    function testTokenTransfer() public {
        (airdrop, bagelToken) = deployer.deployMerkleAirdrop();
        uint256 airdropBalance = bagelToken.balanceOf(address(airdrop));
        assertEq(airdropBalance, AMOUNT_TO_TRANSFER, "Incorrect token balance in MerkleAirdrop after transfer");
    }
}
