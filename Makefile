-include .env

.PHONY: all test clean deploy fund help install snapshot format anvil zktest

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
DEFAULT_ZKSYNC_LOCAL_KEY := 0x7726827caac94a7f9e1b160f7ea819f172f7b6f9d2a97f992c38edeab82d4110

all: clean remove install update build

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install :; forge install cyfrin/foundry-devops@0.2.2 --no-commit && forge install foundry-rs/forge-std@v1.8.2 --no-commit && forge install openzeppelin/openzeppelin-contracts@v5.0.2 --no-commit

# Update Dependencies
update:; forge update

build:; forge build

test :; forge test 

zktest :; foundryup-zksync && forge test --zksync && foundryup

snapshot :; forge snapshot

format :; forge fmt

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

ifeq ($(findstring --network sepolia,$(ARGS)),--network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --account sepolia-acc --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
endif

deploy:
	@forge script script/DeployHelloWorld.s.sol:DeployHelloWorld $(NETWORK_ARGS)

deploy-sepolia:
	@forge script script/DeployHelloWorld.s.sol:DeployHelloWorld --rpc-url $(SEPOLIA_RPC_URL) --account sepolia-acc --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

interact:
	@forge script script/Interactions.s.sol:InteractionsScript $(NETWORK_ARGS) --sender $(SENDER)

interact-sepolia:
	@forge script script/Interactions.s.sol:InteractionsScript --rpc-url $(SEPOLIA_RPC_URL) --account sepolia-acc --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

prefix-sepolia:
	@forge script script/Interactions.s.sol:SetPrefixScript --rpc-url $(SEPOLIA_RPC_URL) --account sepolia-acc --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv


# script for minting the moodNft
# script for flipping the moodNft