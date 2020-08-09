
pragma solidity ^0.5.17;

contract FunctionsExample{
    mapping(address => uint) public balanceReceived;
    
    address payable owner;
    
    constructor() public{
        owner = msg.sender;
    }
    
    function getOwner() public view returns(address){
        return owner;
    }
    
    function convertWeiToEther(uint _amountInWei) public pure returns(uint){
        return _amountInWei / 1 ether;
    }
    
    
    function destroySmartContract() public{
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(owner);
    }
    
    function receiveMoney() public payable {
        assert(balanceReceived[msg.sender] + msg.value >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += msg.value;
    }
    
    function withdrawMoney(address payable _to , uint _amount) public {
        require(_amount <= balanceReceived[msg.sender], "Your dont have enought balance");
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
        
    }
    
    //fallback
    function () external payable {
        receiveMoney();
    }
}