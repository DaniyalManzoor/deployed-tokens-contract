// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import { console } from "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Token is ERC20 {
    uint8 private dec;

    constructor(
        address _address,
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _initialSupply
    ) ERC20(_name, _symbol) {
        dec = _decimals;
        _mint(_address, _initialSupply);
    }

    function decimals() public view virtual override returns (uint8) {
        return dec;
    }
}

contract DeployListedTokens {
    struct TOKEN {
        string name;
        string symbol;
        uint8 decimals;
    }

    TOKEN[] public todos;

    constructor() {
        todos.push(TOKEN("USD Coin", "USDC", 6));
        todos.push(TOKEN("Wrapped Bitcoin", "WBTC", 8));
        todos.push(TOKEN("Tether", "USDT", 6));
        todos.push(TOKEN("Dai", "DAI", 18));
        todos.push(TOKEN("Weth", "WETH", 18));
    }

    function deployERC20Tokens() public {
        for (uint8 i = 0; i < todos.length; i++) {
            TOKEN storage tokenDes = todos[i];
            uint256 totalSupply = 100000000 * 10 ** uint256(tokenDes.decimals);
            new Token(msg.sender, tokenDes.name, tokenDes.symbol, tokenDes.decimals, totalSupply);
        }
    }
}
