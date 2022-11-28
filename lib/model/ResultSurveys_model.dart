class ResultModel {
  final String linkresult;

  ResultModel({required this.linkresult});
  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(linkresult: json['linkresult'] as String);
  }
}
