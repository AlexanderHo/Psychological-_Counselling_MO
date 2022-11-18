class QuestionModel {
  final int id;
  final String description;

  QuestionModel({
    required this.id,
    required this.description,
  });
  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] as int,
      description: json['description'] as String,
    );
  }
}
