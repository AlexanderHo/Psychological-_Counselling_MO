class RoomModel {
  final int? id;
  final String? chanelName;
  final String? token;
  final int? slotId;
  RoomModel(
      {required this.id,
      required this.chanelName,
      required this.token,
      required this.slotId});
  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
        id: json['id'],
        chanelName: json['chanelName'],
        token: json['token'],
        slotId: json['slotId']);
  }
}
