#!/bin/bash

NODE="https://rpc.euphoria.aura.network:443"
ACCOUNT="my-first-wallet"
CHAINID="euphoria-1"
CONTRACT_DIR="artifacts/aura_nft.wasm"
SLEEP_TIME="15s"

CW721_MINTER_CONTRACT_ADDR="aura14gp9d4euw4kehxarar7r3l903nqef6qz8mgw5w6cewtjantz7m6q9tgpv4"
CW20_TOKEN_ADDR="aura1e30u7tkfmq9fueyuwtmnep3wl8rrdcj2gusvylsruzpn7cfaavtqhx76sz"
AMOUNT_WITHOUT_DENOM="$1"

SEND_CW20_TOKEN_TO_CW721_MINTER_CONTRACT="{\"send\": {\"contract\":\"$CW721_MINTER_CONTRACT_ADDR\", \"amount\":\"$AMOUNT_WITHOUT_DENOM\", \"msg\": \"\"}}"
echo $SEND_NFT

RES=$(aurad tx wasm execute "$CW20_TOKEN_ADDR" "$SEND_CW20_TOKEN_TO_CW721_MINTER_CONTRACT" --from "$ACCOUNT" -y --output json --chain-id "$CHAINID" --node "$NODE" --gas 35000000 --fees 35000ueaura -y --output json)
echo $RES

TXHASH=$(echo $RES | jq -r .txhash)
echo $TXHASH

# sleep for chain to update
sleep "$SLEEP_TIME"

RAW_LOG=$(aurad query tx "$TXHASH" --chain-id "$CHAINID" --node "$NODE" -o json | jq -r .raw_log)

echo $RAW_LOG