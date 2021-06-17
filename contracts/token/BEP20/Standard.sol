// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./lib/BEP20.sol";

import "../../service/ServicePayer.sol";
import "../../utils/GeneratorCopyright.sol";

/**
 * @title Standard
 * @author Kazifier - BEP20 Generator (https://kazifier.vercel.app)
 * @dev Implementation of the Standard
 */
contract Standard is BEP20, ServicePayer, GeneratorCopyright("v2.0.0") {

    constructor (
        string memory name,
        string memory symbol,
        uint256 initialBalance,
        address payable feeReceiver
    )
        BEP20(name, symbol)
        ServicePayer(feeReceiver, "Standard")
        payable
    {
        require(initialBalance > 0, "Standard: supply cannot be zero");

        _mint(_msgSender(), initialBalance);
    }
}
