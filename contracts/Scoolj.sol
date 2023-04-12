// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
 
contract Scoolj is ERC20, Ownable {
    mapping(address => bool) private isCandidate;
    address[] private candidates;

    uint constant _initial_supply = 100 * (10**18);
    constructor() ERC20("Scoolj", "SCJ"){
        _mint(msg.sender, _initial_supply);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }


    function checkCandidate(address userWallet) public view returns(bool){
        return isCandidate[userWallet];
    }

    function getAllCandidates() public view returns (address[] memory){
        return candidates;
    }

    function addWallet(address userAddress ) public {
        require(
            !isCandidate[userAddress],  'You are already a candidate for the airdrop'
        );

        isCandidate[userAddress] = true;
        candidates.push(userAddress);
    }

    function airdrop(address[] calldata recipients, uint256 amount ) public onlyOwner {
        for(uint256 i=0; i < recipients.length; i++){
            if(isCandidate[recipients[i]]){
                _transfer(msg.sender, recipients[i], amount);
            }
        }
    }


    
}