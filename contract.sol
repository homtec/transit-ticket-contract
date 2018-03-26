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

contract ticket is owned, mortal {
    /* Define variables */

    uint8 start_gtfs_stop_id;

    uint256 start_time;

    uint8 product_id;

    /* This runs when the contract is executed */
    function ticket(uint8 _start_gtfs_stop_id, uint8 _product_id  ) public {

        start_gtfs_stop_id = _start_gtfs_stop_id;
        start_time = now;
        product_id = _product_id;
    }

    function isValidwithin5Minutes() public view returns (bool) {
      if (now >= start_time + 5 * 1 minutes) {
        return false;
      }
      return true;
    }

    function printStartTime() public constant returns (uint256) {
      return start_time;
    }

    function printStopId() public constant returns (uint8) {
      return start_gtfs_stop_id;
    }

    function printProductId() public constant returns (uint8) {
      return product_id;
    }

}
