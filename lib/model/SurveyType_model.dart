import 'package:astrology/model/Survey_model.dart';

class SurveysTypeModel {
  final int id;
  final String name;
  List<SurveysModel> SurveyList;

  SurveysTypeModel(
      {required this.id, required this.name, required this.SurveyList});
  factory SurveysTypeModel.fromJson(Map<String, dynamic> json) {
    return SurveysTypeModel(
      id: json['id'] as int,
      name: json['name'] as String,
      SurveyList: new List<SurveysModel>.from(
          json['surveys'].map((x) => SurveysModel.fromJson(x))),
    );
  }
}
