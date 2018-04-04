pragma solidity ^0.4.21;


contract owned {
    function owned() public { owner = msg.sender; }
    address owner;
}

// Use `is` to derive from another contract. Derived
// contracts can access all non-private members including
// internal functions and state variables. These cannot be
// accessed externally via `this`, though.
contract mortal is owned {
    function kill() public {
        if (msg.sender == owner) selfdestruct(owner);
    }
}

contract Ticket is mortal {
    /* Define variables */

    uint256 public start_gtfs_stop_id;

    uint256 public start_time;

    uint8 public product_id;

    string public name;

    address public transport_agency_address;

    uint public price = 1;

    bool public ticket_active = false;

    /* This runs when the contract is executed */
    function Ticket( string _name, address _agency ) public {
        transport_agency_address = _agency;
        name = _name;
    }

        /* This runs when the contract is executed */

    function BuyTicket(uint256 _start_gtfs_stop_id, uint8 _product_id  ) public payable {
        require(msg.value >= price);
        start_gtfs_stop_id = _start_gtfs_stop_id;
        start_time = now;
        product_id = _product_id;
        ticket_active = true;
        //send amount to agency
        transport_agency_address.transfer(msg.value);
    }

    function deposit() payable public {
      //deposits[msg.sender] += msg.value;
    }


    function isValid() public view returns (bool) {

        if(!ticket_active) return false;
      if (now >= start_time + 3 * 1 minutes) {
        return false;
      }
      return true;
    }
}
