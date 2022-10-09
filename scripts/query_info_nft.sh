#!/bin/bash

NODE="https://rpc.euphoria.aura.network:443"
ACCOUNT="my-first-wallet"
CHAINID="euphoria-1"
CONTRACT_DIR="artifacts/aura_nft.wasm"
SLEEP_TIME="15s"
CW721_ADDRESS="aura1z6x7ch6qmseyzyj0ns3k09y00cys02p23pc8ehhuxnjrj8martesjud6sf"

ALL_NFTS_QUERY="{\"all_tokens\": {}}"
echo $(aurad query wasm contract-state smart "$CW721_ADDRESS" "$ALL_NFTS_QUERY" --node "$NODE" --output json)


# CHANGE TOKEN_ID HERE
# $# is to check number of arguments
TOKEN_ID="$1"

SINGLE_NFT_QUERY="{\"all_nft_info\": {\"token_id\": \"$TOKEN_ID\"}}"
echo $(aurad query wasm contract-state smart "$CW721_ADDRESS" "$SINGLE_NFT_QUERY" --node "$NODE" --output json | jq --color-output -r )