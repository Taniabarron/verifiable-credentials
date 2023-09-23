pragma solidity ^0.5.1;

contract VerifiableCredentials{
    // Structs
    struct Admin{
        bool status;
        bool isSupreme;
    }

    struct Issuer{
        bool status;
    }

    struct HashCredential{
        address issuer;
        bool status;
    }

    // Mappings
    mapping(address => Admin) private admins;
    mapping(address => Issuer) private issuers;
    mapping(address => HashCredential) private credentials;

    // Main function
    constructor(address _newAdmin){
        admins[_newAdmin].status = true;
        admins[_newAdmin].isSupreme = true;
    }

    // Events
    event successAddAdmin(address admin);
    event successRevokeAdmin(address admin);
    event successAddIssuer(address issuer);
    event successRevokeIssuer(address issuer);
    event successAddCredential(address issuer);
    event successRevokeCredential(address issuer);
    event successChangeTranfer(string message);

    // Functions
    function addAdmin(address _newAdmin) public {
        require(admins[msg.sender].isSupreme == true, "Error: You don't have SuperAdmin privileges");
        admins[_newAdmin].status = true;
        emit successAddAdmin(_newAdmin);
    }

    function revokeAdmin(address _addressAdmin) public {
        require(admins[msg.sender].isSupreme == true, "Error: You don't have SuperAdmin privileges");
        admins[_addressAdmin].status = false;
        emit successRevokeAdmin(_addressAdmin);
    }

    function addIssuer(address _newIssuer) public {
        require(admins[msg.sender].status == true, "Error: You don't have Admin privileges");
        issuers[_newIssuer].status = true;
        emit successAddIssuer(_newIssuer);
    }
    
    function getIssuerStatus(address _addressIssuer) public view returns(bool){
        return issuers[_addressIssuer].status;
    }

    function revokeIssuer(address _addressIssuer) public {
        require(admins[msg.sender].status == true, "Error: You don't have Admin privileges");
        issuers[_addressIssuer].status = false;
        emit successRevokeIssuer(_addressIssuer);
    }
    
    function addCredential(string memory _hashCred ) public {
        require(issuers[msg.sender].status, "Error: This Issuer doesn't exist");
        require(credentials[_hashCred].issuer == address(0), "Error: This Hash Credential has already been registred");
        credentials[_hashCred].issuer = msg.sender;
        credentials[_hashCred].status = true;
        emit successAddCredential(_hashCred);
    }
 
    function revokeCredential (string memory _hashCred) public {
        require(issuers[msg.sender].status,"Error: You can not Revoke this credential because you are not registered as an issuer");
        require(credentials[_hashCred].issuer != address(0), "Error: This credential doesn't exist");
        require(credentials[_hashCred].issuer == msg.sender, "Error: You don't issue this credential");
        require(credentials[_hashCred].status,"Error: This credential is already revoked");
        
        credentials[_hashCred].status = false;
        emit successRevokeCredential(_hashCred);
    }
 
    function verifyCredential (string memory _hashCred) public view returns(bool) {
        require(credentials[_hashCred].issuer != address(0), "Error: This credential doesn't exist");
        return credentials[_hashCred].status;
    }

    function transferCredential(string memory _previousHash, string memory _newHashCred) public {
        require(issuers[msg.sender].status, "Error: This Issuer doesn't exist");
        require(credentials[_previousHash].issuer != address(0), "Error: This credential doesn't exist");
        require(credentials[_newHashCred].issuer == address(0), "Error: Credential new hash is already exist");
        require(credentials[_previousHash].issuer == msg.sender, "Error : can't transfer this credential");
        // revoke
        credentials[_previousHash].status = false;
        // adding with new credential hash
        credentials[_newHashCred].issuer = msg.sender;
        credentials[_newHashCred].status = true;
    }
}