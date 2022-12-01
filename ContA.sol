// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract ContA {

  string name = "SCDEVSTR";
  uint256 cost = 66;

  function getInfo_A() public view returns (string memory, uint256) {
    return (name, cost);
  }

  function updateInfo_B(string memory _newName, uint256 _newCost) public {
    name = _newName;
    cost = _newCost;
  }
}