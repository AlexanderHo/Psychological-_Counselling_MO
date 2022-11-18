class TransactionModel {
  final int id;
  final String dateCreate;
  final String? description;

  TransactionModel(
      {required this.id, required this.dateCreate, required this.description});

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
        id: json['id'] as int,
        dateCreate: json['dateCreate'] as String,
        description: json['description'] as String?);
  }
}
