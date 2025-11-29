// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {Counter} from "../src/Counter.sol";

contract CounterScript is Script {
    Counter public counter;
    address public owner;
    uint256 public deployerKey;
    string public rpcUrl;

    function setUp() public {}

    function run() public {

        deployerKey = vm.envUint("DEPLOYER_PRIVATE_KEY"); // your wallet private key
        owner = vm.addr(deployerKey);

        rpcUrl = vm.envString("RPC_URL"); // your rpc url, ex: Infura/Alchemy
        vm.createSelectFork(rpcUrl);

        vm.startBroadcast(deployerKey);

        counter = new Counter();

        vm.stopBroadcast();
    }
}
