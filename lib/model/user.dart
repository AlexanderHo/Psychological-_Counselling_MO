class UserModel {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String address;
  final String dob;
  final String imageUrl;
  final String birthchart;
  final String gender;
  final int zodiacId;
  final List<Profile> profileList;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.address,
      required this.dob,
      required this.phone,
      required this.imageUrl,
      required this.birthchart,
      required this.gender,
      required this.zodiacId,
      required this.profileList});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['fullname'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      dob: json['dob'] as String,
      phone: json['phone'] == null ? '' : json['phone'] as String?,
      imageUrl: json['imageUrl'] as String,
      birthchart: json['birthchart'] as String,
      gender: json['gender'] as String,
      zodiacId: json['zodiacId'] as int,
      profileList: new List<Profile>.from(
          json['profiles'].map((x) => Profile.fromJson(x))),
    );
  }
}

class Profile {
  final int id;
  final String name;
  final String birthDate;
  final String birthPlace;
  final String birthChart;
  // final double longitude;
  // final double latitude;
  late final int userId;
  final String gender;

  Profile(
      {required this.id,
      required this.name,
      required this.birthDate,
      required this.birthPlace,
      required this.birthChart,
      // required this.longitude,
      // required this.latitude,
      required this.userId,
      required this.gender});
  void setUserId(int userID) {
    this.userId = userID;
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as int,
      name: json['name'] as String,
      birthDate: json['dob'] as String,
      birthPlace: json['birthPlace'] as String,
      birthChart: json['birthChart'] as String,
      // longitude: json['longitude'].toDouble(),
      // latitude: json['latitude'].toDouble(),
      userId: json['customerId'] as int,
      gender: json['gender'] as String,
    );
  }
}
