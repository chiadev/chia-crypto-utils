// ignore_for_file: lines_longer_than_80_chars

class ChiaWalletSet {
  ChiaWalletSet({
    required this.hardened,
    required this.unhardened,
  });
  factory ChiaWalletSet.fromRow(List<dynamic> row) {
    final hardenedVector = ChiaWalletVector(
      childPublicKeyHex: row[0] as String,
      puzzlehashHex: row[1] as String,
    );
    final unhardenedVector = ChiaWalletVector(
      childPublicKeyHex: row[2] as String,
      puzzlehashHex: row[3] as String,
    );

    return ChiaWalletSet(
      hardened: hardenedVector,
      unhardened: unhardenedVector,
    );
  }
  ChiaWalletVector hardened;
  ChiaWalletVector unhardened;
}

class ChiaWalletVector {
  ChiaWalletVector({
    required this.childPublicKeyHex,
    required this.puzzlehashHex,
  });
  String childPublicKeyHex;
  String puzzlehashHex;
}
