# Real Estate Marketplace
This project involves using ERC721 non-fungible tokens (NFT) to represent Real Estate assets.
Zero knowledge proofs (zk-snarks) are used to ensure that only an owner is able to mint tokens for a Real Estate asset.
Assets are listed on [OpenSea marketplace testnet](https://testnets.opensea.io/) on the Rinkeby network.

## Contract Address:
- 0x7f734b5a215cdb6fa76a176816820a9480fb212f
- View history on etherscan: https://rinkeby.etherscan.io/address/0x7f734b5a215cdb6fa76a176816820a9480fb212f

## Token ID (number on the left) and Tx (on the right) for Tokens minted:
1. [0xe00a0dd757f43a4151e2ac380ae7925a98deca5320b6d69445fb245b4fcd714c](https://rinkeby.etherscan.io/tx/0xe00a0dd757f43a4151e2ac380ae7925a98deca5320b6d69445fb245b4fcd714c)
2. [0xaf738da4665b2dbed11a90a4e08f4443f3796c1c394e8983138eb092098b4f84](https://rinkeby.etherscan.io/tx/0xaf738da4665b2dbed11a90a4e08f4443f3796c1c394e8983138eb092098b4f84)
3. [0xc042a7fc979ea80721efc950e1a553976343d2978b025a67295dbb8525384189](https://rinkeby.etherscan.io/tx/0xc042a7fc979ea80721efc950e1a553976343d2978b025a67295dbb8525384189)
4. [0x92aa088051caeb530d3227d8c64659d073a93f214cafd4bcf410dcf69f115a4c](https://rinkeby.etherscan.io/tx/0x92aa088051caeb530d3227d8c64659d073a93f214cafd4bcf410dcf69f115a4c)
5. [0x3d14b1a574a0fd90a4ab47f6a4c6fc05bb584285deea3506b58afc9063aff5e3](https://rinkeby.etherscan.io/tx/0x3d14b1a574a0fd90a4ab47f6a4c6fc05bb584285deea3506b58afc9063aff5e3)
6. [0xfbe41b54c2ef462cccb205d1977deaa9b2927bfe629b09ccd199ede37aaa5b56](https://rinkeby.etherscan.io/tx/0xfbe41b54c2ef462cccb205d1977deaa9b2927bfe629b09ccd199ede37aaa5b56)
7. [0x3d0b902933285131de3d0b4214d7cee8590c1cfe89b077a1842992bc63872d31](https://rinkeby.etherscan.io/tx/0x3d0b902933285131de3d0b4214d7cee8590c1cfe89b077a1842992bc63872d31)
8. [0xa3de7056b3d09292bee9e20f24ca5eeea8d0905aa8faba21bddd02ef573c9258](https://rinkeby.etherscan.io/tx/0xa3de7056b3d09292bee9e20f24ca5eeea8d0905aa8faba21bddd02ef573c9258)
9. [0x59392f6e9fb6e841eef6f090a2edbbc3a2925b2a70ae16bc8b6c60b4f4624dd7](https://rinkeby.etherscan.io/tx/0x59392f6e9fb6e841eef6f090a2edbbc3a2925b2a70ae16bc8b6c60b4f4624dd7)
10. [0xb2b0bc10a370e734ab0b3e58dc730b8de582a9f6b7db658451981e46043d0889](https://rinkeby.etherscan.io/tx/0xb2b0bc10a370e734ab0b3e58dc730b8de582a9f6b7db658451981e46043d0889)

## Opensea marketplace storefront
[My Contract storefront](https://testnets.opensea.io/collection/unidentified-contract-wqrsmtbiwu)

## Token Transfer Tx's
1. https://rinkeby.etherscan.io/tx/0x1b1f29961c0ba7c3b88e74604a580f503bf8a753ea17f5f2e5fc09b032be1f73
2. https://rinkeby.etherscan.io/tx/0xb0acbe89d3731b8f8bedbe4671407645a0573fac6fcd9104ed727a077c5dd1ff
3. https://rinkeby.etherscan.io/tx/0xc38caeb5ce18999135ee913a7973d200d13aeccbece9c759a6c31e655f0be755
4. https://rinkeby.etherscan.io/tx/0xde5092773622b109176b1d645ec58e97f53a6586b9d4878ac52846941c528fe0
5. https://rinkeby.etherscan.io/tx/0x507301dd0fd8b40e8e152e9cc5b7246f894206447043e393661e933f66fdacfd

## Running the tests
### Prerequisites

- Ensure `ganache-cli`, or `ganache-gui` (if using ganache-gui, you would need to change the port in truffle-config.js to 7545).
- Ensure `truffle` (specifically version 5.4.9 to avoid versioning issues) is installed.

### **To Run the tests**

1. Install dependencies
```bash
# install all modules listed as dependencies in package.json
npm install
```

2. Start Ganache-cli
```bash
# Start Ganache cli local Ethereum
ganache-cli
```

3. Executing the test scripts
```bash
# This should compile the contracts, migrate then and execute the relevant tests for the project.
truffle test
````

### **Minting the tokens**
1. Start Zokrates in Docker and generate a unique proof.json
```bash
zokrates compute-witness -a a b
# a and b are arguments for the proof function

zokrates generate-proof
# This generates the proof.json. You need to provide this in order to mintTokens
```

2. Start truffle console on the rinkeby network
```bash
truffle console --network rinkeby
```

3. Migrate the contracts **(IF YOU HAVE NOT DONE THIS ALREADY)**
```bash
> migrate
```

4. Get contract and proof an execute the mint command
```bash
> let tokenProof = require("../path/to/proof.json")
> let contract = await SolnSquareVerifier.deployed()
> contract.mintToken("address to mint to" , tokenIdNumber, tokenProof.proof.a, tokenProof.proof.b, tokenProof.proof.c, tokenProof.inputs)

```



# Project Resources

* [Remix - Solidity IDE](https://remix.ethereum.org/)
* [Visual Studio Code](https://code.visualstudio.com/)
* [Truffle Framework](https://truffleframework.com/)
* [Ganache - One Click Blockchain](https://truffleframework.com/ganache)
* [Open Zeppelin ](https://openzeppelin.org/)
* [Interactive zero knowledge 3-colorability demonstration](http://web.mit.edu/~ezyang/Public/graph/svg.html)
* [Docker](https://docs.docker.com/install/)
* [ZoKrates](https://github.com/Zokrates/ZoKrates)
* [Helpful video](https://www.youtube.com/watch?v=axdymRYSHTs)
