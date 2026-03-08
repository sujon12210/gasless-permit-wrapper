// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @title GaslessVault
 * @dev Simple vault that allows deposits via EIP-2612 Permit.
 */
contract GaslessVault {
    IERC20 public immutable token;
    mapping(address => uint256) public balances;

    constructor(address _token) {
        token = IERC20(_token);
    }

    /**
     * @dev Deposit tokens using an off-chain signature (Permit).
     * The caller (relayer) pays the gas, but the 'owner' is the one whose tokens are moved.
     */
    function depositWithPermit(
        address owner,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external {
        // Execute the permit to grant this contract allowance
        IERC20Permit(address(token)).permit(owner, address(this), value, deadline, v, r, s);

        // Move the tokens
        token.transferFrom(owner, address(this), value);
        balances[owner] += value;
    }
}
