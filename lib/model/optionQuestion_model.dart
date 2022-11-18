class OptionModel {
  final int id;
  final String optionText;
  final String type;
  final String question;
  final int questionId;

  OptionModel(
      {required this.id,
      required this.optionText,
      required this.type,
      required this.question,
      required this.questionId});

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
        id: json['id'] as int,
        optionText: json['optionText'] as String,
        type: json['type'] as String,
        question: json['question'] as String,
        questionId: json['questionId'] as int);
  }
}
