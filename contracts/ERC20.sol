pragma solidity ^0.8.8;

contract ERC20 {

    string _name;
    string _symbol;
    uint256 _totalSupply;
    mapping(address=>uint256) _balanceOf;
    mapping(address=>mapping(address=>uint256)) _allowance;

    constructor(string memory name_, string memory symbol_, uint256 totalSupply_, address owner)
    {
        _name=name_;
        _symbol=symbol_;
        _totalSupply = totalSupply_;
        _balanceOf[owner]=totalSupply_;
    }

    function name() public view returns (string memory){
        return _name;
    }
    function symbol() public view returns (string memory){
        return _symbol;
    }
    function decimal() public pure returns (uint8){
        return 18;
    }
    function totalSupply() public view returns (uint256)
    {
        return _totalSupply;
    }
    function balanceOf(address _owner) public view returns (uint256 balance)
    {
        return _balanceOf[_owner];
    }
    function allowance(address _owner, address _spender) public view returns (uint256 remaining)
    {
        return _allowance[_owner][_spender];
    }
    function transfer(address _to,uint256 _value) public returns(bool success){
        uint256 fromBalance = _balanceOf[msg.sender];
        require(fromBalance >= _value, "Insufficeient amount");
        _balanceOf[msg.sender] = fromBalance - _value;
        _balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to , _value); //lab5c ex3
        return true;
    }
    function approve(address _spender, uint256 _value) external returns (bool success) {
        address owner = msg.sender;
        _allowance[owner][_spender] = _value;
        emit Approval(msg.sender, _spender , _value); //lab5c ex4
        return true;
    }
    function transferFrom(address _from, address _to, uint256 _value) external returns(bool success) {
        address spender = msg.sender;
        uint256 currentAllowance = _allowance[_from][spender];
        require(currentAllowance >= _value, "Insufficient allowance");
        _allowance[_from][spender] = currentAllowance - _value;
        //proceed with the transfer
        uint256 fromBalance = _balanceOf[_from];
        require(fromBalance >= _value, "Insufficient balance");
        _allowance[_from][spender] = currentAllowance - _value;
        //deduct amount from owner balance, increase amount in receipent
        _balanceOf[_from] = fromBalance - _value;
        _balanceOf[_to] += _value;
        emit Transfer(_from, _to , _value);
        return true;
    }
    event Transfer(address indexed _from , address indexed _to, uint256 _value);
    event Approval(address indexed _owner , address indexed _spender, uint256 _value);
}
