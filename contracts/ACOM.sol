// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ACOM is ERC20 {
    // Define tokenomics parameters
    uint256 private constant TOTAL_SUPPLY = 10_000_000_000 * 10**18; // 10 Billion tokens
    uint256 private constant TREASURY_SUPPLY = TOTAL_SUPPLY * 90 / 100; // 90% for Smart Treasury Fund
    uint256 private constant LIQUIDITY_SUPPLY = TOTAL_SUPPLY * 10 / 100; // 10% for Strategic Liquidity Planning

    // Address of the contract owner (deployer)
    address private _owner;

    // Address of the Smart Treasury Fund
    address private _treasuryFund;

    // Address of the Strategic Liquidity Pool
    address private _liquidityPool;

    constructor() ERC20("ACOM", "ACOM") {
        // Assign the contract owner
        _owner = msg.sender;

        // Mint tokens to the Smart Treasury Fund
        _mint(address(this), TREASURY_SUPPLY);

        // Assign the rest of the tokens to the Strategic Liquidity Pool
        _mint(_owner, LIQUIDITY_SUPPLY);

        // Set the addresses of the Treasury Fund and Liquidity Pool
        _treasuryFund = address(this);
        _liquidityPool = _owner;
    }

    // Function to transfer tokens from the Treasury Fund to another address
    function transferFromTreasury(address recipient, uint256 amount) external onlyOwner {
        _transfer(address(this), recipient, amount);
    }

    // Function to transfer tokens from the Strategic Liquidity Pool to another address
    function transferFromLiquidity(address recipient, uint256 amount) external onlyOwner {
        _transfer(_owner, recipient, amount);
    }

    // Function to change the address of the Strategic Liquidity Pool (only callable by the owner)
    function changeLiquidityPool(address newPool) external onlyOwner {
        require(newPool != address(0), "Invalid address");
        _liquidityPool = newPool;
    }

    // Function to retrieve the address of the Strategic Liquidity Pool
    function getLiquidityPool() external view returns (address) {
        return _liquidityPool;
    }

    // Function to transfer ownership of the contract to another address (only callable by the owner)
    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Invalid address");
        _owner = newOwner;
    }

    // Modifier to restrict access to the owner
    modifier onlyOwner() {
        require(msg.sender == _owner, "Caller is not the owner");
        _;
    }
}
