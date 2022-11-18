import 'package:http/http.dart';

class SlotModel {
  final int id;
  final String? timeStart;
  final String? timeEnd;
  final int? price;
  final String? dateSlot;
  final String? description;
  final String? consultantName;
  final String? imageUrl;
  final String? status;
  final int? bookingId;
  final int consultantId;

  SlotModel(
      {required this.id,
      required this.timeStart,
      required this.timeEnd,
      required this.price,
      required this.dateSlot,
      required this.description,
      required this.consultantName,
      required this.imageUrl,
      required this.status,
      required this.consultantId,
      required this.bookingId});

  factory SlotModel.fromJson(Map<String, dynamic> json) {
    return SlotModel(
        id: json['id'] as int,
        timeStart: json['timeStart'] as String?,
        timeEnd: json['timeEnd'] as String?,
        price: json['price'] as int?,
        dateSlot: json['dateSlot'] as String?,
        description: json['description'] as String?,
        consultantName: json['consultantName'] as String?,
        imageUrl: json['imageUrl'] as String?,
        status: json['status'] as String?,
        consultantId: json['consultantId'] as int,
        bookingId: json['bookingId'] as int?);
  }

  // SlotModel.general(
  //     {required this.slotId,
  //     required this.timeStart,
  //     required this.timeEnd,
  //     required this.price,
  //     required this.dateSlot,
  //     required this.consultantId,
  //     required this.bookingId})
  //     : consultantName = '',
  //       imageUrl = '',
  //       status='';
}
