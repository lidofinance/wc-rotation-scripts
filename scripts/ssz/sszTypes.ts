import { ContainerType, ByteVectorType, UintNumberType, UintBigintType, BooleanType } from '@chainsafe/ssz';

export const Bytes4 = new ByteVectorType(4);
export const Bytes20 = new ByteVectorType(20);
export const Bytes32 = new ByteVectorType(32);
export const Bytes48 = new ByteVectorType(48);

export const UintNum64 = new UintNumberType(8);

export const ValidatorIndex = UintNum64;
export const WithdrawalIndex = UintNum64;
export const Root = new ByteVectorType(32);

export const Version = Bytes4;
export const DomainType = Bytes4;
export const BLSPubkey = Bytes48;
export const Domain = Bytes32;
export const ExecutionAddress = Bytes20;

export const ForkData = new ContainerType(
  {
    currentVersion: Version,
    genesisValidatorsRoot: Root,
  },
  { typeName: 'ForkData', jsonCase: 'eth2' },
);

export const SigningData = new ContainerType(
  {
    objectRoot: Root,
    domain: Domain,
  },
  { typeName: 'SigningData', jsonCase: 'eth2' },
);

export const BLSToExecutionChange = new ContainerType(
  {
    validatorIndex: ValidatorIndex,
    fromBlsPubkey: BLSPubkey,
    toExecutionAddress: ExecutionAddress,
  },
  { typeName: 'BLSToExecutionChange', jsonCase: 'eth2' },
);
