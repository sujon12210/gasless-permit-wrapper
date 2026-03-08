const { ethers } = require("ethers");

async function signERC20Permit(wallet, tokenAddress, spender, value, deadline, chainId) {
    const domain = {
        name: "MyToken", // Must match the Token contract name
        version: "1",
        chainId: chainId,
        verifyingContract: tokenAddress,
    };

    const types = {
        Permit: [
            { name: "owner", type: "address" },
            { name: "spender", type: "address" },
            { name: "value", type: "uint256" },
            { name: "nonce", type: "uint256" },
            { name: "deadline", type: "uint256" },
        ],
    };

    // Nonce must be fetched from the token contract: await token.nonces(owner)
    const nonce = 0; 

    const message = {
        owner: wallet.address,
        spender: spender,
        value: value,
        nonce: nonce,
        deadline: deadline,
    };

    const signature = await wallet.signTypedData(domain, types, message);
    return ethers.Signature.from(signature);
}

module.exports = { signERC20Permit };
