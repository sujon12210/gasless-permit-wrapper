# Gasless Permit Wrapper

This repository provides a standard-compliant way to implement gasless transactions. By leveraging the `permit` function found in modern ERC-20 tokens, users can sign a structured data message (EIP-712) to grant allowance, which a relayer then submits to the blockchain, paying the gas fee on the user's behalf.

## How it Works
1. **Sign**: The user signs a `Permit` message off-chain using their private key.
2. **Relay**: A third-party "Relayer" receives the signature and the transaction data.
3. **Execute**: The Relayer calls the `vaultDepositWithPermit` function. The contract verifies the signature and transfers tokens in a single atomic transaction.



## Features
* **Zero-Gas UX**: Users only need tokens, not the native chain currency (ETH/BNB/MATIC).
* **EIP-712 Compliant**: Secure, typed data hashing that prevents phishing.
* **Deadline Protection**: Signatures expire after a set time to prevent long-term exposure.

## Setup
1. Use an ERC-20 that supports `permit` (like USDC or DAI).
2. Deploy the `GaslessVault.sol`.
3. Use the provided JavaScript utility to generate signatures.

## License
MIT
