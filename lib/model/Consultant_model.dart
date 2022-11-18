class ConsultantModel {
  final int id;
  final String fullName;
  final String? imageUrl;
  final String? avartarUrl;
  final String email;
  final String address;
  final String dob;
  final String gender;
  final String phone;
  final String status;
  final int? experience;
  final double? rating;

  ConsultantModel(
      {required this.id,
      required this.fullName,
      required this.imageUrl,
      required this.avartarUrl,
      required this.email,
      required this.address,
      required this.dob,
      required this.gender,
      required this.phone,
      required this.status,
      required this.experience,
      required this.rating});

  factory ConsultantModel.fromJson(Map<String, dynamic> json) {
    return ConsultantModel(
        id: json['id'] as int,
        fullName: json['fullName'] as String,
        imageUrl: json['imageUrl'] as String?,
        avartarUrl: json['avartarUrl'] as String?,
        email: json['email'] as String,
        address: json['address'] as String,
        dob: json['dob'] as String,
        gender: json['gender'] as String,
        phone: json['phone'] as String,
        status: json['status'] as String,
        experience: json['experience'] as int?,
        rating: json['rating'] == null ? 0.0 : json['rating'].toDouble());
  }

  ConsultantModel.general(
      {required this.id,
      required this.fullName,
      required this.imageUrl,
      required this.gender,
      required this.experience,
      required this.address,
      required this.rating})
      : status = '',
        email = '',
        dob = '',
        phone = '',
        avartarUrl = '';

  factory ConsultantModel.fromGeneralJson(Map<String, dynamic> json) {
    return ConsultantModel.general(
      id: json['id'] as int,
      fullName: json['fullName'] as String,
      imageUrl: json['imageUrl'] as String?,
      gender: json['gender'] as String,
      address: json['address'] as String,
      experience: json['experience'] as int?,
      rating: json['rating'] == null ? 0.0 : json['rating'].toDouble(),
    );
  }
}
