class NotiModel {
  final int id;
  final String dateCreate;
  final String description;
  final String? type;
  final String status;

  NotiModel(
      {required this.id,
      required this.dateCreate,
      required this.description,
      required this.type,
      required this.status});

  factory NotiModel.fromJson(Map<String, dynamic> json) {
    return NotiModel(
        id: json['id'] as int,
        dateCreate: json['dateCreate'] as String,
        description: json['description'] as String,
        type: json['type'] as String?,
        status: json['status'] as String);
  }
}
