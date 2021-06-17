#!/usr/bin/env bash

for contract in "Capped" "Standard" "Owned" "Flare" "Harvest" "Flarvest" "Infinity" "Ultimate"
do
  npx truffle-flattener contracts/token/BEP20/$contract.sol > dist/$contract.dist.sol
done

npx truffle-flattener contracts/service/ServiceReceiver.sol > dist/ServiceReceiver.dist.sol
