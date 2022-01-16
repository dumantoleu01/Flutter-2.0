const String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    id, symbol, name, price,
  ];

  static const String id = '_id';
  static const String symbol = 'symbol';
  static const String name = 'name';
  static const String price = 'price';
}

class Note {
  final int? id;
  final String symbol;
  final String name;
  final double price;

  const Note({
    this.id,
    required this.symbol,
    required this.name,
    required this.price,
  });

  Note copy({
    int? id,
    String? symbol,
    String? name,
    double? price,
  }) =>
      Note(
        id: id ?? this.id,
        symbol: symbol ?? this.symbol,
        name: name ?? this.name,
        price: price ?? this.price,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        symbol: json[NoteFields.symbol] as String,
        name: json[NoteFields.name] as String,
        price: json[NoteFields.price] as double,
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.symbol: symbol,
        NoteFields.name: name,
        NoteFields.price: price,
      };
}
