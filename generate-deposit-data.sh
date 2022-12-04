#!/bin/bash

source nodes-config.sh

if [ "$1" = "" ]
then
  echo "Withdrawal credentials is requred" && exit 1
fi

cd ./staking-deposit-cli

DIR=../data
rm -rf $DIR/validator_keys

PASSWORD=$(<$CONFIG_DIR/keystore-password.txt)

./deposit.sh install

./deposit.sh \
  --non_interactive \
  --language=en \
  existing-mnemonic \
  --withdrawal_credentials=$1 \
  --chain=testnet20000089 \
  --num_validators=32 \
  --folder=$DIR \
  --keystore_password="$PASSWORD" \
  --validator_start_index=0 \
  --mnemonic="aban aban aban aban aban aban aban aban aban aban aban abou"
