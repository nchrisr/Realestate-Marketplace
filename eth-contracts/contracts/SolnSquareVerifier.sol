pragma solidity >=0.4.21 <0.6.0;

import "./ERC721Mintable.sol";
import "./verifier.sol";


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

    struct Solution {
        uint256 index;
        address to;
    }


    Solution[] solutions;


    mapping(bytes32 => Solution) private uniqueSolutions;

    event SolutionAdded(address to, uint256 index);

    function addSolution(address _to, uint256 _index, bytes32 _key) internal {
        Solution memory _solution = Solution({index : _index, to : _to});
        solutions.push(_solution);
        uniqueSolutions[_key] = _solution;
        emit SolutionAdded(_to, _index);
    }


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
