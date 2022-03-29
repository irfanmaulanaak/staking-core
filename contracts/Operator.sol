// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.7.6;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract Operator {
    using SafeERC20 for IERC20;
    address payable public _owner;
    mapping(address => bool) public operators;

    constructor(address _ownerAddress) public {
        _owner = payable(_ownerAddress);
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "You're not an owner.");
        _;
    }
    
    modifier onlyOperators() {
        require(operators[msg.sender], "You're not an operator.");
        _;
    }

    function getOwner() public view returns (address) {
        return _owner;
    }

    function setOwner(address payable _newOwner) external onlyOwner{
        require(_newOwner != address(0));
        _owner = _newOwner;
    }

    function setOperator(address _operator, bool _value) external onlyOwner{
        operators[_operator] = _value;
    }
}