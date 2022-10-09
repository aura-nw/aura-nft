#!/bin/bash

NODE="https://rpc.euphoria.aura.network:443"
ACCOUNT="my-first-wallet"
CHAINID="euphoria-1"
CONTRACT_DIR="artifacts/aura_nft.wasm"
SLEEP_TIME="15s"

CODE_ID="$1"

INIT="{
	\"cw20_address\":\"aura1e30u7tkfmq9fueyuwtmnep3wl8rrdcj2gusvylsruzpn7cfaavtqhx76sz\", 
	\"max_tokens\":100, 
	\"name\":\"Aura NFT Test Token\", 
	\"owner\":\"$(aurad keys show $ACCOUNT -a)\", 
	\"symbol\":\"ANT\", 
	\"token_code_id\": 117, 
	\"token_uri\": \"https://res.cloudinary.com/stargaze/image/upload/w_700/qg9ch3mcfp2bbm09uw7q.mp4\", 
	\"unit_price\": \"1000\"
	}"
INIT_JSON=$(aurad tx wasm instantiate "$CODE_ID" "$INIT" --from "$ACCOUNT" --label "Aura NFT Test Token" -y --chain-id "$CHAINID" --node "$NODE" --no-admin --gas 3000000 --fees 35000ueaura -o json)

echo "INIT_JSON = $INIT_JSON"

if [ "$(echo $INIT_JSON | jq -r .raw_log)" != "[]" ]; then
	# exit
	echo "ERROR = $(echo $INIT_JSON | jq .raw_log)"
	exit 1
else
	echo "INSTANTIATE SUCCESS"
fi

# sleep for chain to update
sleep "$SLEEP_TIME"

RAW_LOG=$(aurad query tx "$(echo $INIT_JSON | jq -r .txhash)" --chain-id "$CHAINID" --node "$NODE" --output json | jq -r .raw_log)

echo "RAW_LOG = $RAW_LOG"

CONTRACT_ADDRESS=$(echo $RAW_LOG | jq -r .[0].events[0].attributes[0].value)

echo "CONTRACT ADDRESS = $CONTRACT_ADDRESS"

