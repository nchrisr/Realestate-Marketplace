var ERC721MintableComplete = artifacts.require('ERC721MintableRealEstate');

contract('TestERC721Mintable', accounts => {

    const account_one = accounts[0];
    const account_two = accounts[1];
    const account_three = accounts[2];
    const account_four = accounts[3];

    describe('match erc721 spec', function () {
        beforeEach(async function () { 
            this.contract = await ERC721MintableComplete.new({from: account_one});

            // TODO: mint multiple tokens
            await this.contract.mint(account_two, 1);
            await this.contract.mint(account_three, 2);
            await this.contract.mint(account_four, 3);
        });

        it('should return total supply', async function () {
            let totalSupply = await this.contract.totalSupply.call()
            assert.equal(totalSupply.toNumber(), 3, 'Inaccurate total supply');
        })

        it('should get token balance', async function () { 
            await this.contract.mint(account_two, 4, {from: account_one});
            let balanceForAccountTwo = await this.contract.balanceOf.call(account_two, {from: account_two});
            let balanceForAccountThree = await this.contract.balanceOf.call(account_three, {from: account_three});
            let balanceForAccountFour = await this.contract.balanceOf.call(account_four, {from: account_four});
            assert.equal(balanceForAccountTwo.toNumber(), 2, "Inaccurate balance");
            assert.equal(balanceForAccountThree.toNumber(), 1, "Inaccurate balance");
            assert.equal(balanceForAccountFour.toNumber(), 1, "Incaccurate balance");
        });

        // token uri should be complete i.e: https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/1
        it('should return token uri', async function () {
            let expectedTOkenURI = "https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/1";
            let actualTokenURI = await this.contract.tokenURI.call(1);
            assert.equal(expectedTOkenURI, actualTokenURI, "Inaccurate tokenURI");
            expectedTOkenURI = "https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/2";
            actualTokenURI = await this.contract.tokenURI.call(2);
            assert.equal(expectedTOkenURI, actualTokenURI, "Inaccurate tokenURI");
        })

        it('should transfer token from one owner to another', async function () {
            let theTokenId = 1;
            await this.contract.transferFrom(account_two, account_three, theTokenId, {from: account_two});
            let tokenOwner = await this.contract.ownerOf.call(theTokenId);
            assert.equal(account_three, tokenOwner, "Token not transferred.");

            theTokenId = 2;
            await this.contract.transferFrom(account_three, account_four, theTokenId, {from: account_three});
            tokenOwner = await this.contract.ownerOf.call(theTokenId);
            assert.equal(account_four, tokenOwner, "Token not transferred.");

        })
    });

    describe('have ownership properties', function () {
        beforeEach(async function () { 
            this.contract = await ERC721MintableComplete.new({from: account_one});
        })

        it('should fail when minting when address is not contract owner', async function () {
            let failed = false;
            try {
                await this.contract.mint(account_four, 5, { from: account_two });
            } catch (e) {
                failed = true;
            }
            assert.equal(failed, true, "caller is not the contract owner");
        })

        it('should return contract owner', async function () {
            let contractOwner = await this.contract.getContractOwner.call({ from: account_one });
            assert.equal(contractOwner, account_one, "Owner should be account_one");
        })

    });
})
