class FeedBackModel {
  final int id;
  final String feedback;
  final int rate;
  final String dateCreate;
  final String customerName;
  final int bookingId;

  FeedBackModel(
      {required this.id,
      required this.feedback,
      required this.rate,
      required this.dateCreate,
      required this.customerName,
      required this.bookingId});

  factory FeedBackModel.fromJson(Map<String, dynamic> json) {
    return FeedBackModel(
        id: json['id'],
        feedback: json['feedback'],
        rate: json['rate'],
        dateCreate: json['dateCreate'],
        customerName: json['customerName'],
        bookingId: json['bookingId']);
  }
}
