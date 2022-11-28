class DailyModel {
  final int? id;
  final String? imageUrl;
  final String? date;
  final String? context;
  final String? job;
  final String? affection;
  final int? luckyNumber;
  final String? goodTime;
  final String? color;
  final String? shouldThing;
  final String? shouldNotThing;

  DailyModel(
      {required this.id,
      required this.imageUrl,
      required this.date,
      required this.context,
      required this.job,
      required this.affection,
      required this.luckyNumber,
      required this.goodTime,
      required this.color,
      required this.shouldThing,
      required this.shouldNotThing});

  factory DailyModel.fromJson(Map<String, dynamic> json) {
    return DailyModel(
      id: json['id'],
      imageUrl: json['imageUrl'] as String?,
      date: json['date'] as String?,
      context: json['context'] as String?,
      job: json['job'] as String?,
      affection: json['affection'] as String?,
      luckyNumber: json['luckyNumber'] as int?,
      goodTime: json['goodTime'] as String?,
      color: json['color'] as String?,
      shouldThing: json['shouldThing'] as String?,
      shouldNotThing: json['shouldNotThing'] as String?,
    );
  }
}
