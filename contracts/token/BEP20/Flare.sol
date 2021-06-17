// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./lib/BEP20Burnable.sol";

import "../../service/ServicePayer.sol";

/**
 * @title Flare
 * @dev Implementation of the Flare
 */
contract Flare is BEP20Burnable, ServicePayer {

    constructor (
        string memory name,
        string memory symbol,
        uint8 decimals,
        uint256 initialBalance,
        address payable feeReceiver
    )
        BEP20(name, symbol)
        ServicePayer(feeReceiver, "Flare")
        payable
    {
        require(initialBalance > 0, "Flare: supply cannot be zero");

        _setupDecimals(decimals);
        _mint(_msgSender(), initialBalance);
    }
}
