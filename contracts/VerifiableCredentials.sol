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
    
}