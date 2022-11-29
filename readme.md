# Scripts for withdrawal credential rotation ceremony

## Install

Step 1. Install deps

```bash
yarn
```

Step 2. Create `.env` file from th template

```bash
cp sample.env .env
```

Step 3. Fill out the `.env` file

## Env variables

Some scripts may require some of the following environment variables to be set:

- `EXECUTION_LAYER` – RPC URL of execution layer client
- `CONSENSUS_LAYER` – API URL of consensus layer client
- `PRIVATE_KEY` – `0x` prefixed private key of account with some eth to send transactions

## Scripts

### Public key to withdrawal credentials

The script converts a public key into a withdrawal credentials 0x00 type. It takes the `sha256` from the public key and replaces the first byte to 0.

```bash
yarn convert_pubkey_to_wc tnrKcfBLZzA3tUAJt2Dxlh84NuVxQUHIkq/bdewINNzmeE2ccu2K19syjP+P6fE+
```

Arguments:

- `public key`, required – public key in base64 or hex format to convert to withdrawal credentials

### Send deposit transactions

The script sends deposit transactions to the deposit contract from deposit data file generated by [staking deposit cli](https://github.com/ethereum/staking-deposit-cli).

```bash
yarn send_deposit_txs deposit_data.json
```

Arguments:

- `deposit data path`, required – path to a deposit data file

The script requires env variables to be set:

- `EXECUTION_LAYER`
- `CONSENSUS_LAYER`
- `PRIVATE_KEY`

### Fetch validators indexes by withdrawal credentials

The script fetches data about validators from Consensus Layer and Execution Layer which matches to the passed withdrawal credentials and generates a CSV file with validator indexes. This file can later be used in [dc4bc](https://github.com/lidofinance/dc4bc/) to sign messages to rotate withdrawal credentials from type `0x00` to `0x01`.

The data is fetched from the deposit contract on Execution Layer and the form the finalized state on Consensus Layer to reduce the risk of incorrect data.

```bash
yarn fetch_validators_by_wc -w 0x009690e5d4472c7c0dbdf490425d89862535d2a52fb686333f3a0a9ff5d2125e validators.csv
```

Options:

- `-w`, `--withdrawal-credentials`, required – withdrawal_credentials by which validators will be filtered
- `-s`, `--fetch-step`, optional – step with which events from deposit contract are requested. Reduce this value if there are problems with fetching data (100,000 by default)

Arguments:

- `file path`, required – path to the output file

The script requires env variables to be set:

- `EXECUTION_LAYER`
- `CONSENSUS_LAYER`

File format:

```
1,1001
2,1002
2,2024
...
21,4242
```

### Validate validators indexes file

The script validates data from the validator indexes file:

- Checks gaps in message indexes and their order
- Checks that the file has the same number of validators as in Consensus Layer with the passed withdrawal credential
- Checks that all the validator indexes correspond to the validators on the Consensus Layer with the passed withdrawal credentials

```bash
yarn validate_validators_indexes -w 0x009690e5d4472c7c0dbdf490425d89862535d2a52fb686333f3a0a9ff5d2125e validators.csv
```

Options:

- `-w`, `--withdrawal-credentials`, required – withdrawal_credentials by which validators will be filtered

Arguments:

- `file path`, required – path to the input file

The script requires env variables to be set:

- `CONSENSUS_LAYER`

### Send rotation messages

The scripts sends messages to Consensus Layer node to rotate withdrawal credentials from `0x00` to `0x01` type.

```bash
yarn send_rotation_messages rotation_messages.json
```

Options:

- `-f`, `--from-index`, optional – from index of rotation messages to send
- `-t`, `--to-index`, optional – to index of rotation messages to send

Arguments:

- `file path`, required – path to the input file

File format:

```json
[
  {
    "message": {
      "validator_index": 1,
      "from_bls_pubkey": "0x93247f2209abcacf57b75a51dafae777f9dd38bc7053d1af526f220a7489a6d3a2753e5f3e8b1cfe39b56f43611df74a",
      "to_execution_address": "0xabcf8e0d4e9587369b2301d0790347320302cc09"
    },
    "signature": "0x1b66ac1fb663c9bc59509846d6ec05345bd908eda73e670af888da41af171505cc411d61252fb6cb3fa0017b679f8bb2305b26a285fa2737f175668d0dff91cc1b66ac1fb663c9bc59509846d6ec05345bd908eda73e670af888da41af171505"
  }
]
```
