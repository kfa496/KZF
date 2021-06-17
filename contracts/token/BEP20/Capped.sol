// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./lib/BEP20.sol";

import "../../service/ServicePayer.sol";
import "../../utils/GeneratorCopyright.sol";

/**
 * @title Capped
 * @author Kazifier - BEP20 Generator (https://kazifier.vercel.app)
 * @dev Implementation of the Capped
 */
contract Capped is BEP20, ServicePayer, GeneratorCopyright("v2.0.0") {

    constructor (
        string memory name,
        string memory symbol,
        address payable feeReceiver
    )
        BEP20(name, symbol)
        ServicePayer(feeReceiver, "Capped")
        payable
    {
        _mint(_msgSender(), 100000e18);
    }
}
