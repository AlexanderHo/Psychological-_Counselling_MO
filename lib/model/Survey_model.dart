class SurveysModel {
  final int id;
  final String name;
  final int? surveyTypeId;
  final String? surveyType;

  SurveysModel(
      {required this.id,
      required this.name,
      required this.surveyTypeId,
      required this.surveyType});
  factory SurveysModel.fromJson(Map<String, dynamic> json) {
    return SurveysModel(
        id: json['id'] as int,
        name: json['name'] as String,
        surveyTypeId: json['surveyTypeId'] as int?,
        surveyType: json['surveyType'] as String?);
  }
}
