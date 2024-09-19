# Getting Started
Requirements
git
You'll know you did it right if you can run `git --version` and you see a response like `git version x.x.x`
foundry
You'll know you did it right if you can run `forge --version` and you see a response like `forge 0.2.0 (816e00b 2023-03-16T00:05:26.396218Z)`
To get started, we are assuming you're working with vanilla foundry and not foundry-zksync to start.

# Quickstart
```sh
git clone https://github.com/DCVglobalnetwork/Merkle-Airdrop-tests.git
cd Merkle-Airdrop-tests
```
make # or forge install && forge build if you don't have make 

# Usage
Pre-deploy: Generate merkle proofs
We are going to generate merkle proofs for an array of addresses to airdrop funds to. If you'd like to work with the default addresses and proofs already created in this repo, skip to deploy

If you'd like to work with a different array of addresses (the whitelist list in GenerateInput.s.sol), you will need to follow the following:

First, the array of addresses to airdrop to needs to be updated in `GenerateInput.s.sol. To generate the input file and then the merkle root and proofs, run the following:

Using make: (if you are using Makefile) I do not use in this project so I focus on `forge `
```sh
make merkle
```
Or using the commands directly:
```sh
forge script script/GenerateInput.s.sol:GenerateInput && forge script script/MakeMerkle.s.sol:MakeMerkle
```

# Deploy
Deploy to Anvil
### Optional, ensure you're on vanilla foundry
`foundryup`
### Run a local anvil node
`anvil`
### Then, in a second terminal
`deploy`

# Testing
foundryup
```sh
forge test
```
### Test Coverage
```sh
forge coverage
```
![image](https://github.com/user-attachments/assets/4f6413a3-2ecc-42cf-820e-ff3e9615f4c5)

### Estimate gas
You can estimate how much gas things cost by running:
```sh
forge snapshot
```
![image](https://github.com/user-attachments/assets/b923ff87-19de-4d7e-a548-c88f1bd5d185)

And you'll see an output file called .gas-snapshot

### Formatting
To run code formatting:
```sh
forge fmt
```
# Contributing
We appreciate your interest in contributing to this repository! Specifically, looking for help with expanding more test coverage using Foundry. Here’s how you can contribute:

### How to Contribute
Fork the Repository: Click the "Fork" button on the top-right corner of this page to create your own copy of the repository.

Clone Your Fork: Clone your fork to your local machine to start making changes:
```sh
git clone https://github.com/DCVglobalnetwork/Merkle-Airdrop-tests.git
```

Create a Branch: Create a new branch for your changes:
```sh
git checkout -b add-tests-branch
```
Write Your Tests: Implement additional tests using Foundry. Ensure that your tests cover new scenarios, edge cases, or existing functionality that needs more coverage.

Run Tests: Before submitting your changes, run the tests to ensure everything works as expected:
```sh
forge test
```
Commit Your Changes: Commit your changes with a descriptive message:
```sh
git add .
```
```sh
git commit -m "Add tests for [specific functionality or feature]"
```
Push Your Changes: Push your changes to your fork:
```sh
git push origin add-tests-branch
```
Create a Pull Request: Go to the original repository on GitHub, and click the “New Pull Request” button. Select your branch and submit the pull request.




