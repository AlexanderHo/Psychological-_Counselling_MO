class ResultModel {
  final String linkresult;

  ResultModel({required this.linkresult});
  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(linkresult: json['linkresult'] as String);
  }
}

class Result {
  final String resultofsurvey;
  final String discchart;
  final String birthchart;

  Result(
      {required this.resultofsurvey,
      required this.discchart,
      required this.birthchart});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
        resultofsurvey: json['resultofsurvey'] as String,
        discchart: json['discchart'] as String,
        birthchart: json['birthchart'] as String);
  }
}
