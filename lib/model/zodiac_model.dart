class ZodiacModel {
  final int id;
  final String imageUrl;
  final String name;
  final int? dayStart;
  final int? monthStart;
  final int? dayEnd;
  final int? monthEnd;
  // final String dateStart;
  // final String dateEnd;
  final String descriptionShort;
  final String descriptionDetail;

  ZodiacModel(
      {required this.id,
      required this.name,
      // required this.dateStart,
      // required this.dateEnd,
      required this.dayStart,
      required this.dayEnd,
      required this.monthEnd,
      required this.monthStart,
      required this.imageUrl,
      required this.descriptionShort,
      required this.descriptionDetail});

  factory ZodiacModel.fromJson(Map<String, dynamic> json) {
    return ZodiacModel(
        id: json['id'] as int,
        imageUrl: json['imageUrl'] as String,
        name: json['name'] as String,
        // dateStart: json['dateStart'] as String,
        // dateEnd: json['dateEnd'] as String,
        dayStart: json['dayStart'] as int,
        dayEnd: json['dayEnd'] as int,
        monthStart: json['monthStart'] as int,
        monthEnd: json['monthEnd'] as int,
        descriptionShort: json['descriptionShort'] as String,
        descriptionDetail: json['descriptionDetail'] as String);
  }

  ZodiacModel.general({
    required this.id,
    required this.imageUrl,
    required this.name,
  })  : dayStart = 0,
        dayEnd = 0,
        monthEnd = 0,
        monthStart = 0,
        descriptionShort = '',
        descriptionDetail = '';

  factory ZodiacModel.fromGeneralJson(Map<String, dynamic> json) {
    return ZodiacModel.general(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
