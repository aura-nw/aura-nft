#!/bin/bash

NODE="https://rpc.euphoria.aura.network:443"
ACCOUNT="my-first-wallet"
CHAINID="euphoria-1"
CONTRACT_DIR="artifacts/aura_nft.wasm"
SLEEP_TIME="15s"

CW721_MINTER_CONTRACT_ADDR="aura14gp9d4euw4kehxarar7r3l903nqef6qz8mgw5w6cewtjantz7m6q9tgpv4"

CONFIG_QUERY="{\"get_config\": {}}"
CONFIG=$(aurad query wasm contract-state smart "$CW721_MINTER_CONTRACT_ADDR" "$CONFIG_QUERY" --node "$NODE" --output json)

echo $CONFIG
