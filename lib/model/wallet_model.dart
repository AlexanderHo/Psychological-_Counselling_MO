class WalletModel {
  final String name;
  final int crab;

  WalletModel({required this.name, required this.crab});

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(name: json['name'] as String, crab: json['crab'] as int);
  }
}
