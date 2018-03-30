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

contract Ticket is owned, mortal {
    /* Define variables */

    uint256 public start_gtfs_stop_id;

    uint256 public start_time;

    uint8 public product_id;

    string public name;

    address transport_agency_address = 0x9E7d20C9c0484c3152c0e628049e7485B5bd6CD2;

    uint stored_value;

    uint price = 1;

    bool ticket_active = false;

    /* This runs when the contract is executed */
    function Ticket( string _name  ) public {

        name = _name;
    }

        /* This runs when the contract is executed */

    function BuyTicket(uint256 _start_gtfs_stop_id, uint8 _product_id  ) public payable {

    //address x = 0x123;
    //address myAddress = this;
    //if (x.balance < 10 && myAddress.balance >= 10) x.transfer(10);

        //receive payment
        stored_value += msg.value;

        //buy ticket if enough value
        if(stored_value >= price) {
            start_gtfs_stop_id = _start_gtfs_stop_id;
            start_time = now;
            product_id = _product_id;
            ticket_active = true;

            //pay
            //update stored_value
            stored_value -= price;

            //send amount to agency
            transport_agency_address.transfer(price);

        }
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
