// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/HarshCoin.sol";

contract TestHarshCoin is Test {

    HarshCoin c;

    function setup() public{
        c = newHarshCoin();
    }

    function testMint() public{
        c.mint(address(this), 100);
        assertEq(c.balanceOf(address(this)),100,"ok");
        assertEq(0x65798742dB2021DDB0C6C33c71CEc5FedD4F1029, 0, "ok"); 

        c.mint(0x65798742dB2021DDB0C6C33c71CEc5FedD4F1029(this), 100);
        assertEq(0x65798742dB2021DDB0C6C33c71CEc5FedD4F1029, 0, "ok"); 
    }

    function testTransfer() public{
        c.mint(address(this), 100);
        c.transfer(0x65798742dB2021DDB0C6C33c71CEc5FedD4F1029, 50);

        assertEq(c.balanceOf(address(this)), 50)
        assertEq(c.balanceOf(0x65798742dB2021DDB0C6C33c71CEc5FedD4F1029), 50);

        vm.prank(0x65798742dB2021DDB0C6C33c71CEc5FedD4F1029);
        c.transfer(address(this),50);

        assertEq(c.balanceOf(address(this)), 100)
        assertEq(c.balanceOf(0x65798742dB2021DDB0C6C33c71CEc5FedD4F1029), 0);
    }

    function testApprove() public{
        c.mint (address(this),100);

        c.approve(0x65798742dB2021DDB0C6C33c71CEc5FedD4F1029,100);

        assertEq(c.allowance(address(this),0x65798742dB2021DDB0C6C33c71CEc5FedD4F1029), 10);
        
        vm.prank(0x65798742dB2021DDB0C6C33c71CEc5FedD4F1029);
        vm.transferFrom(address(this), 0x65798742dB2021DDB0C6C33c71CEc5FedD4F1029, 5);

        assertEq(c.balanceOf(address(this)), 95, "ok");
        assertEq(c.balanceOf(0x65798742dB2021DDB0C6C33c71CEc5FedD4F1029), 5, "ok");
        assertEq(c.allowance(address(this),0x65798742dB2021DDB0C6C33c71CEc5FedD4F1029), 5);
    }

    function testFailApprovals() public{
        c.mint(address(this), 10);
        c.approve(0x65798742dB2021DDB0C6C33c71CEc5FedD4F1029, 10);

        vm.prank(0x65798742dB2021DDB0C6C33c71CEc5FedD4F1029);
        c.transferFrom(address(this), 0x65798742dB2021DDB0C6C33c71CEc5FedD4F1029, 20);
    }
    
    function testFailTransfer() public{
        c.mint(address(this),20);
        c.transfer(0x65798742dB2021DDB0C6C33c71CEc5FedD4F1029, 100);
    }
}
