class Currency {
  final String code;
  final String symbol;
  final String name;

  const Currency({
    required this.code,
    required this.symbol,
    required this.name,
  });

  String get displayName => '$code – $symbol – $name';

  // Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {'code': code, 'symbol': symbol, 'name': name};
  }

  // Create from Map
  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(
      code: map['code'] as String,
      symbol: map['symbol'] as String,
      name: map['name'] as String,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Currency && other.code == code;
  }

  @override
  int get hashCode => code.hashCode;
}
