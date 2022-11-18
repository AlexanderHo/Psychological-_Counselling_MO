class DepositModel {
  final String? qrcodemomo;
  final String? qrcodebank;
  final String? code;
  final String? name;
  final String? phonenumber;
  final String? banknumber;
  final int amount;

  DepositModel(
      {required this.qrcodemomo,
      required this.qrcodebank,
      required this.code,
      required this.name,
      required this.phonenumber,
      required this.banknumber,
      required this.amount});
  factory DepositModel.fromJson(Map<String, dynamic> json) {
    return DepositModel(
        qrcodemomo: json['qrcodemomo'],
        qrcodebank: json['qrcodebank'],
        code: json['code'],
        name: json['name'],
        phonenumber: json['phonenumber'],
        banknumber: json['banknumber'],
        amount: json['amount']);
  }

  // DepositModel.general({
  //   required this.fileContents,
  //   required this.enableRangeProcessing,
  // })  : contentType = '',
  //       fileDownloadName = '',
  //       lastModified = '',
  //       entityTag = '';

  // factory DepositModel.fromGeneralJson(Map<String, dynamic> json) {
  //   return DepositModel.general(
  //       fileContents: json['fileContents'],
  //       enableRangeProcessing: json['enableRangeProcessing']);
  // }
}
