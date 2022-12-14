CURRENT_DIR=$(readlink -f .)

CONFIG_DIR=$CURRENT_DIR/config
DATA_DIR=$CURRENT_DIR/nodes-data
BUILD_DIR=$CURRENT_DIR/build

PRYSM_DATA_DIR=$DATA_DIR/data-prysm
GETH_DATA_DIR=$DATA_DIR/data-geth
VALIDATOR_DATA_DIR=$DATA_DIR/validator

PRYSM_DIR=./prysm
GETH_DIR=./go-ethereum

ACCOUNT_ADDRESS=0x607894f0fbc9cde4f7746906c509c1003d12f4a5
FEE_RECIPIENT=$ACCOUNT_ADDRESS