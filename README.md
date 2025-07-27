# Uniswap V2 Deployment Project

This project contains a complete Uniswap V2 deployment setup with custom ERC20 tokens, WETH, Factory, Router, and automated liquidity provision.

## 🏗️ Project Structure

```
uniswap-v2-deploy/
├── src/
│   ├── CustomERC20.sol          # Custom ERC20 token implementation
│   ├── WETH9.sol               # Wrapped ETH implementation
│   └── uniswap-v2/            # Updated Uniswap V2 contracts
│       ├── IUniswapV2Factory.sol
│       ├── IUniswapV2Pair.sol
│       ├── UniswapV2Factory.sol
│       ├── UniswapV2Pair.sol
│       └── UniswapV2Router02.sol
├── script/
│   └── DeployUniswap.s.sol     # Deployment script
├── lib/                        # Dependencies
├── foundry.toml               # Foundry configuration
└── README.md                  # This file
```

## 🚀 Features

- **Complete Uniswap V2 Implementation**: Factory, Router, and Pair contracts updated for Solidity 0.8.20
- **Custom ERC20 Tokens**: Deploy your own tokens with minting capabilities
- **Automated Liquidity Provision**: Automatically creates pairs and adds initial liquidity
- **WETH Integration**: Wrapped ETH for ETH/token pairs
- **Gas Optimized**: Updated contracts with modern Solidity features

## 📋 Prerequisites

1. **Foundry**: Install Foundry (forge, cast, anvil)
   ```bash
   curl -L https://foundry.paradigm.xyz | bash
   foundryup
   ```

2. **Environment Setup**: Create a `.env` file with your deployment credentials
   ```bash
   cp .env.example .env
   # Edit .env with your values
   ```

## ⚙️ Configuration

### Environment Variables (.env)
```bash
RPC_URL="your_rpc_endpoint_here"
PRIVATE_KEY="your_private_key_here"
ADDRESS="your_wallet_address_here"
```

### Foundry Configuration (foundry.toml)
```toml
[profile.default]
src = "src"
out = "out"
libs = ["lib"]
solc_version = "0.8.20"
optimizer = true
optimizer_runs = 200

# Remappings for Uniswap V2
remappings = [
    "@uniswap/v2-core/contracts/=lib/v2-core/contracts/",
    "@uniswap/v2-periphery/contracts/=lib/v2-periphery/contracts/",
    "@uniswap/lib/contracts/=lib/v2-periphery/contracts/",
    "@openzeppelin/contracts/=lib/openzeppelin-contracts/contracts/",
    "forge-std/=lib/forge-std/src/",
    "v2-core/=lib/v2-core/contracts/",
    "v2-periphery/=lib/v2-periphery/contracts/"
]
```

## 🔧 Setup Instructions

1. **Clone and Install Dependencies**
   ```bash
   git clone <repository-url>
   cd uniswap-v2-deploy
   forge install
   ```

2. **Load Environment Variables**
   ```bash
   source .env
   ```

3. **Compile Contracts**
   ```bash
   forge build
   ```

## 🚀 Deployment

### Quick Deployment
```bash
forge script script/DeployUniswap.s.sol \
  --fork-url $RPC_URL \
  --private-key $PRIVATE_KEY \
  --broadcast \
  --legacy \
  --slow
```

### Deployment Steps

The deployment script will automatically:

1. **Deploy WETH** - Wrapped ETH contract
2. **Deploy Factory** - Uniswap V2 Factory contract
3. **Deploy Router** - Uniswap V2 Router with factory and WETH
4. **Deploy Tokens** - Two custom ERC20 tokens (TokenA, TokenB)
5. **Mint Tokens** - Mint additional tokens to deployer
6. **Create Pair** - Create trading pair between tokens
7. **Add Liquidity** - Add initial liquidity to the pair

### Expected Output
```
WETH deployed at: 0x...
Factory deployed at: 0x...
Router deployed at: 0x...
TokenA deployed at: 0x...
TokenB deployed at: 0x...
Pair created at: 0x...
Token0: 0x...
Token1: 0x...
Liquidity added. Deployer: 0x...
```

## 🔍 Troubleshooting

### Common Issues

1. **Nonce Mismatch Error**
   ```bash
   # Use --slow flag to handle nonce issues
   forge script script/DeployUniswap.s.sol --fork-url $RPC_URL --private-key $PRIVATE_KEY --broadcast --legacy --slow
   ```

2. **EIP-1559 Fee Error**
   ```bash
   # Use --legacy flag for legacy transactions
   forge script script/DeployUniswap.s.sol --fork-url $RPC_URL --private-key $PRIVATE_KEY --broadcast --legacy
   ```

3. **Compilation Errors**
   ```bash
   # Clean and rebuild
   forge clean
   forge build
   ```

4. **Environment Variables Not Set**
   ```bash
   # Source environment file
   source .env
   ```

### Network-Specific Notes

- **Testnets**: Use appropriate RPC URLs (Sepolia, Goerli, etc.)
- **Mainnet**: Ensure sufficient ETH for gas fees
- **Private Networks**: Adjust gas settings as needed

## 📊 Contract Addresses

After deployment, you'll have these contracts:

- **WETH**: Wrapped ETH for ETH/token pairs
- **Factory**: Creates and manages trading pairs
- **Router**: Handles swaps and liquidity operations
- **TokenA**: First custom ERC20 token
- **TokenB**: Second custom ERC20 token
- **Pair**: Trading pair between TokenA and TokenB

## 🛠️ Development

### Adding New Tokens
1. Create new ERC20 contract in `src/`
2. Update deployment script to deploy new token
3. Add liquidity provision for new token

### Customizing Deployment
Edit `script/DeployUniswap.s.sol` to:
- Change token names and symbols
- Modify initial token supply
- Adjust liquidity amounts
- Add more tokens

### Testing
```bash
# Run tests
forge test

# Run with verbose output
forge test -vvv
```
