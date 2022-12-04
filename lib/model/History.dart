class HistoryModel {
  final int slotId;
  final String? timeStart;
  final String? timeEnd;
  final int? price;
  final String? dateSlot;
  final String? description;
  final String? reasonOfCustomer;
  final String? reasonOfConsultant;
  final String? status;
  final int? bookingId;
  final int consultantId;
  final String? booking;
  final String? consultant;
  final int? roomVideoCall;

  HistoryModel(
      {required this.slotId,
      required this.timeStart,
      required this.timeEnd,
      required this.price,
      required this.dateSlot,
      required this.description,
      required this.reasonOfCustomer,
      required this.reasonOfConsultant,
      required this.status,
      required this.consultantId,
      required this.bookingId,
      required this.booking,
      required this.consultant,
      required this.roomVideoCall});

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
        slotId: json['slotId'] as int,
        timeStart: json['timeStart'] as String?,
        timeEnd: json['timeEnd'] as String?,
        price: json['price'] as int?,
        dateSlot: json['dateSlot'] as String?,
        description: json['description'] as String?,
        reasonOfCustomer: json['reasonOfCustomer'] as String?,
        reasonOfConsultant: json['reasonOfConsultant'] as String?,
        status: json['status'] as String?,
        consultantId: json['consultantId'] as int,
        bookingId: json['bookingId'] as int?,
        booking: json['booking'] as String?,
        consultant: json['consultant'] as String?,
        roomVideoCall: json['roomVideoCall'] as int?);
  }
}
