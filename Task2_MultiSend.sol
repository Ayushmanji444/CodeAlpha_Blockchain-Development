// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MultiSend {

    event TransferSuccessful(address indexed recipient, uint256 amount);

    function multiSend(address payable[] memory recipients) public payable {
        require(recipients.length > 0, "No recipients provided");
        require(msg.value > 0, "Must send some Ether");

        uint256 amountPerRecipient = msg.value / recipients.length;
        require(amountPerRecipient > 0, "Amount too small to split");

        for (uint256 i = 0; i < recipients.length; i++) {
            (bool success, ) = recipients[i].call{value: amountPerRecipient}("");
            require(success, "Transfer failed");
            emit TransferSuccessful(recipients[i], amountPerRecipient);
        }
    }

    // Optional: check contract balance (should be 0 after a successful multiSend,
    // but useful if leftover wei from division remainder gets stuck)
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
