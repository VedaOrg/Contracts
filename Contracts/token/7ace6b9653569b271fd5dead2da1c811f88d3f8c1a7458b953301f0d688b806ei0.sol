// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20Token is ERC20 {
    uint256 public maxSupply;
    uint256 public mintAmount;
    uint8 private decimalPlaces;

    constructor(
        string memory name, 
        string memory symbol, 
        uint256 _maxSupply, 
        uint8 _decimalPlaces, 
        uint256 _mintAmount
    ) 
    ERC20(name, symbol) {
        maxSupply = _maxSupply;
        mintAmount = _mintAmount;
        decimalPlaces = _decimalPlaces;
    }

    function decimals() public view virtual override returns (uint8) {
        return decimalPlaces;
    }

    function mint() public {
        require(tx.origin == msg.sender, "Only the original external account can call this method");
        require(totalSupply() + mintAmount <= maxSupply, "Max supply exceeded");
        _mint(msg.sender, mintAmount);
    }
}
