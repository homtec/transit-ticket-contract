pragma solidity ^0.4.17;


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

    /* This runs when the contract is executed */
    function Ticket(uint256 _start_gtfs_stop_id, uint8 _product_id, string _name  ) public {

        start_gtfs_stop_id = _start_gtfs_stop_id;
        start_time = now;
        product_id = _product_id;
        name = _name;
    }

    function isValid() public view returns (bool) {
      if (now >= start_time + 3 * 1 minutes) {
        return false;
      }
      return true;
    }
}
