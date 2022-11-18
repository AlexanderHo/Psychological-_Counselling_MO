class BookingModel {
  final int? id;
  final double? price;
  final String? feedback;
  final String? duration;
  final String? dateBooking;
  final int? paymentId;
  final int? consultantId;
  final int? customerId;
  final String? status;

  BookingModel(
      {required this.id,
      required this.price,
      required this.feedback,
      required this.duration,
      required this.dateBooking,
      required this.paymentId,
      required this.consultantId,
      required this.customerId,
      required this.status});

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
        id: json['id'],
        price: json['price'],
        feedback: json['feedback'],
        duration: json['duration'],
        dateBooking: json['dateBooking'],
        paymentId: json['paymentId'],
        consultantId: json['consultantId'],
        customerId: json['customerId'],
        status: json['status']);
  }
}
