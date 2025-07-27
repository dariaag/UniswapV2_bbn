// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "../src/uniswap-v2/UniswapV2Factory.sol";
import "../src/uniswap-v2/UniswapV2Router02.sol";
import "../src/CustomERC20.sol";
import "../src/WETH9.sol";

contract DeployUniswap is Script {
    function run() external {
        vm.startBroadcast();

        // Deploy WETH
        WETH9 weth = new WETH9();
        console2.log("WETH deployed at:", address(weth));

        // Deploy Uniswap Factory
        UniswapV2Factory factory = new UniswapV2Factory(msg.sender);
        console2.log("Factory deployed at:", address(factory));

        // Deploy Router
        UniswapV2Router02 router = new UniswapV2Router02(address(factory), address(weth));
        console2.log("Router deployed at:", address(router));

        // Deploy Tokens
        CustomERC20 tokenA = new CustomERC20("TokenA", "TKA", 1_000_000 ether);
        CustomERC20 tokenB = new CustomERC20("TokenB", "TKB", 1_000_000 ether);
        console2.log("TokenA deployed at:", address(tokenA));
        console2.log("TokenB deployed at:", address(tokenB));

        // Mint extra tokens to deployer
        tokenA.mint(msg.sender, 500_000 ether);
        tokenB.mint(msg.sender, 500_000 ether);

        // Approve router
        tokenA.approve(address(router), type(uint256).max);
        tokenB.approve(address(router), type(uint256).max);

        // Create Pair
        address pair = factory.createPair(address(tokenA), address(tokenB));
        console2.log("Pair created at:", pair);

        // Get the correct token order (token0 < token1)
        (address token0, address token1) =
            address(tokenA) < address(tokenB) ? (address(tokenA), address(tokenB)) : (address(tokenB), address(tokenA));

        console2.log("Token0:", token0);
        console2.log("Token1:", token1);

        // Add Liquidity with correct token order
        router.addLiquidity(token0, token1, 10_000 ether, 10_000 ether, 0, 0, msg.sender, block.timestamp + 1000);

        console2.log("Liquidity added. Deployer:", msg.sender);

        vm.stopBroadcast();
    }
}
