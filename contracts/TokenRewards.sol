// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract TokenRewards is Ownable, ReentrancyGuard {
    using SafeERC20 for IERC20;

    uint256 public lastUpdatedBlock;

    mapping(address => uint256) public rewards;

    IERC20 public immutable token; // WELA

    event AddTokenReward(address indexed user, uint256 block, uint256 amount);
    event WithdrawTokenRewards(
        address indexed user,
        uint256 block,
        uint256 amount
    );
    event RescueToken(
        address indexed user,
        address indexed token,
        uint256 amount
    );

    constructor(
        IERC20 _token,
        uint256 _startBlock,
        address initialOwner
    ) Ownable(initialOwner) {
        token = _token;
        lastUpdatedBlock = _startBlock;
    }

    receive() external payable {}

    function setLastUpdateBlock(uint256 _lastUpdatedBlock) external onlyOwner {
        lastUpdatedBlock = _lastUpdatedBlock;
    }

    function addTokenReward(address _user, uint256 _amount) external onlyOwner {
        rewards[_user] += _amount;

        token.safeTransferFrom(msg.sender, address(this), _amount);

        emit AddTokenReward(_user, block.number, _amount);
    }

    function addTokenRewards(
        address[] memory _users,
        uint256[] memory _amounts
    ) external onlyOwner {
        require(_users.length == _amounts.length, "Arrays are not equal");

        for (uint256 i = 0; i < _users.length; i++) {
            rewards[_users[i]] += _amounts[i];

            token.safeTransferFrom(msg.sender, address(this), _amounts[i]);

            emit AddTokenReward(_users[i], block.number, _amounts[i]);
        }
    }

    function withdrawTokenRewards() external nonReentrant {
        if (rewards[msg.sender] > 0) {
            uint256 amount = rewards[msg.sender];

            rewards[msg.sender] = 0;

            token.safeTransfer(msg.sender, amount);

            emit WithdrawTokenRewards(msg.sender, block.number, amount);
        }
    }

    function rescueToken(
        address rewardToken,
        address addressForReceive
    ) external onlyOwner {
        uint256 balance = IERC20(rewardToken).balanceOf(address(this));
        IERC20(token).safeTransfer(addressForReceive, balance);
        emit RescueToken(msg.sender, rewardToken, balance);
    }
}
