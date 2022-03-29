// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.7.6;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "./Operator.sol";

contract Reward is Operator{
    IERC20 public rewardToken;
    address public master;
    using SafeERC20 for IERC20;

    event Send(address To, uint256 Amount, address Caller);
    event Withdraw(address To, address Token, address Caller, uint256 Amount);

    constructor(IERC _rewardToken, address _owner) public Operator(_owner){
        rewardToken = _rewardToken;
    }
    
    function setMaster(address _master) public onlyOwner {
        master = _master;
    }
    
    function send(address _to, uint256 _amount) public {
        require(msg.sender == owner() || msg.sender == master, "Master or Owner can't call this function.");
        ggg.safeTransfer(_to, _amount);
        emit Send(_to, _amount, msg.sender);
    }

    function withdraw(address _token, address payable _to) external onlyOwner {
        uint256 amount = 0;
        if (_token == address(0x0)) {
            amount = address(this.balance);
            payable(_to).transfer(amount);
        }
        else{
            amount = IERC20(_token).balanceOf(address(this));
            IERC20(_token).safeTransfer(_to, amount);
        }
        emit Withdraw(_to, _token, msg.sender, amount);
    }
}
