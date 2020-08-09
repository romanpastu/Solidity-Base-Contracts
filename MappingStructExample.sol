pragma solidity ^0.5.17;

contract MappingStructExample {
    
    struct Payment {
        uint amount;
        uint timestamps;
    }
    
    struct Balance{
        uint totalBalance;
        uint numPayments; 
        mapping(uint => Payment) payments;
    }
    
    mapping(address => Balance) public balanceReceived;
    
    function getBalance() public view returns(uint){
        return address(this).balance;
    }
    
    function sendMoney() public payable {
        balanceReceived[msg.sender].totalBalance += msg.value; //Add to total balance
        
        Payment memory payment = Payment(msg.value, now);  //create a payment struct
        balanceReceived[msg.sender].payments[balanceReceived[msg.sender].numPayments] = payment;  //Save the payment struct
        balanceReceived[msg.sender].numPayments++;
    }
    
    function withdrawMoney(address payable _to, uint _amount) public {
        require(balanceReceived[msg.sender].totalBalance >= _amount, "not enought funds");
        balanceReceived[msg.sender].totalBalance -= _amount;
        _to.transfer(_amount);
    }
    
    function withdrawAllMoney(address payable _to) public {
        uint balanceToSend = balanceReceived[msg.sender].totalBalance;
        balanceReceived[msg.sender].totalBalance = 0;
        _to.transfer(balanceToSend);
    }
}