// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
import {BagelToken} from "../src/BagelToken.sol";
import {ZkSyncChainChecker} from "lib/foundry-devops/src/ZkSyncChainChecker.sol";
import {DeployMerkleAirdrop} from "../script/DeployMerkleAirdrop.s.sol";

contract MerkleAirdropTest is ZkSyncChainChecker, Test {
    MerkleAirdrop public airdrop;
    BagelToken public token;
    address user;
    uint256 userPrivKey;

    bytes32 public ROOT = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    uint256 public AMOUNT_TO_CLAIM = (25 * 1e18); // 25.000000
    uint256 public AMOUNT_TO_SEND = AMOUNT_TO_CLAIM * 4;

    bytes32 proofOne = 0x0fd7c981d39bece61f7499702bf59b3114a90e66b51ba2c53abdf7b62986c00a;
    bytes32 proofTwo = 0xe5ebd1e1b5a5478a944ecab36a9a954ac3b6b8216875f6524caa7a1d87096576;
    bytes32[] PROOF = [proofOne, proofTwo];

    function setUp() external {
        if (!isZkSyncChain()) {
            DeployMerkleAirdrop deployer = new DeployMerkleAirdrop();
            (airdrop, token) = deployer.deployMerkleAirdrop();
        } else {
            token = new BagelToken();
            // Deploy the MerkleAirdrop contract with the root and token address
            airdrop = new MerkleAirdrop(ROOT, token);

            // Mint tokens to the airdrop contract for distribution
            token.mint(token.owner(), AMOUNT_TO_SEND); // Mint sufficient tokens to cover the airdrop
            token.transfer(address(airdrop), AMOUNT_TO_SEND);
        }
        // Create a user and their private key
        (user, userPrivKey) = makeAddrAndKey("user");
    }

    function testUsersCanClaim() public {
        // Log the starting balance for debugging
        uint256 startingBalance = token.balanceOf(user);
        console.log("Starting balance for user: %d", startingBalance);

        // Prank the user for simulating their interaction
        vm.prank(user);

        // User claims their tokens from the airdrop
        airdrop.claim(user, AMOUNT_TO_CLAIM, PROOF);

        // Log the ending balance for debugging
        uint256 endingBalance = token.balanceOf(user);
        console.log("Ending balance for user: %d", endingBalance);

        // Ensure that the user received the expected amount
        assertEq(endingBalance - startingBalance, AMOUNT_TO_CLAIM);
    }

    function testDeployMerkleAirdrop() public view {
        assertTrue(address(airdrop) != address(0), "MerkleAirdrop not deployed");
        assertTrue(address(token) != address(0), "BagelToken not deployed");

        uint256 balance = token.balanceOf(address(airdrop));
        assertEq(balance, AMOUNT_TO_SEND, "Incorrect token balance in MerkleAirdrop");
    }
}
