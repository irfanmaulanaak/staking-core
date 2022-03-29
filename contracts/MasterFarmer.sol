// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.7.6;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./uniswapv3/interfaces/IUniswapV3Pool.sol";
import "./Factory.sol";
import "./Vault.sol";
import "./Reward.sol";
import "./Factory.sol";

contract MasterFarmer is Ownable, Factory {
  using SafeMath for uint256;
  using SafeERC20 for IERC20;
  struct UserInfo {
    uint256 amount;
    uint256 rewardDebt;
    uint256 luaDebt;
    uint256 rewardDebtAtBlock;
  }

  struct PoolInfo {
    IERC20 lpToken;
    uint256 allocPoint;
    uint256 lastRewardBlock;
    uint256 accLuaPerShare;
    uint256 accRewardPerShare;
  }
  IERC20 public depositedToken;
  IERC20 public rewardToken;
  Vault public vault;
  Reward public reward;

  address public operator;

  PoolInfo[] public poolInfo;
  mapping(address => uint256) public poolId1;
  mapping (uint256 => mapping (address => userInfo)) public userInfo;

}
