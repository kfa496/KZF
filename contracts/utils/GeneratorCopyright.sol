// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @title GeneratorCopyright
 * @author Kazifier - BEP20 Generator (https://kazifier.vercel.app)
 * @dev Implementation of the GeneratorCopyright
 */
contract GeneratorCopyright {

    string private constant _GENERATOR = "https://kazifier.vercel.app";
    string private _version;

    constructor (string memory version_) {
        _version = version_;
    }

    /**
     * @dev Returns the token generator tool.
     */
    function generator() public pure returns (string memory) {
        return _GENERATOR;
    }

    /**
     * @dev Returns the token generator version.
     */
    function version() public view returns (string memory) {
        return _version;
    }
}
