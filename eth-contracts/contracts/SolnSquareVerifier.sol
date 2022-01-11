pragma solidity >=0.4.21 <0.6.0;

import "./ERC721Mintable.sol";
import "./verifier.sol";

// TODO define a contract call to the zokrates generated solidity contract <Verifier> or <renamedVerifier>


// TODO define another contract named SolnSquareVerifier that inherits from your ERC721Mintable class
contract SolnSquareVerifier is ERC721MintableRealEstate{

    modifier solutionIsCorrect(
        uint[2] memory a,
        uint[2][2] memory b,
        uint[2] memory c,
        uint[2] memory input){
        require(verifierContract.verifyTxUsable(a,b,c, input), "Solution is not correct");
        _;
    }

    Verifier public verifierContract;

    constructor(address verifierAddress) ERC721MintableRealEstate() public{
        verifierContract = Verifier(verifierAddress);
    }

    // TODO define a solutions struct that can hold an index & an address
    struct Solution {
        uint256 index;
        address to;
    }

    // TODO define an array of the above struct
    Solution[] solutions;

    // TODO define a mapping to store unique solutions submitted
    mapping(bytes32 => Solution) private uniqueSolutions;

    // TODO Create an event to emit when a solution is added
    event SolutionAdded(address to, uint256 index);

    // TODO Create a function to add the solutions to the array and emit the event
    function addSolution(address _to, uint256 _index, bytes32 _key) internal {
        Solution memory _solution = Solution({index : _index, to : _to});
        solutions.push(_solution);
        uniqueSolutions[_key] = _solution;
        emit SolutionAdded(_to, _index);
    }

    // TODO Create a function to mint new NFT only after the solution has been verified
    //  - make sure the solution is unique (has not been used before)
    //  - make sure you handle metadata as well as tokenSupply
    function mintToken(
        address _to,
        uint256 _tokenId,
        uint[2] memory a,
        uint[2][2] memory b,
        uint[2] memory c,
        uint[2] memory input
    ) public solutionIsCorrect(a, b, c, input) {
        // hash solution to get key
        bytes32 key = keccak256(abi.encodePacked(a, b, c, input));
        //  - make sure the solution is unique (has not been used before)
        require(uniqueSolutions[key].to == address(0), "Solution is already used.");
        addSolution(_to, _tokenId, key);
        //  - make sure you handle metadata as well as tokenSupply
        super.mint(_to, _tokenId);
    }

}
