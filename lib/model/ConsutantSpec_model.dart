class ConsultantSpecModel {
  final String? specialName;
  final int consultantId;
  final String? name;
  final String? imageUrl;
  final String email;
  final String? address;
  final String? dob;
  final String? gender;
  final String? phone;
  final int? experience;
  final double? rating;

  ConsultantSpecModel(
      {required this.consultantId,
      required this.name,
      required this.imageUrl,
      required this.email,
      required this.address,
      required this.dob,
      required this.gender,
      required this.phone,
      required this.specialName,
      required this.experience,
      required this.rating});

  factory ConsultantSpecModel.fromJson(Map<String, dynamic> json) {
    return ConsultantSpecModel(
        consultantId: json['consultantId'] as int,
        name: json['name'] as String?,
        imageUrl: json['imageUrl'] as String?,
        email: json['email'] as String,
        address: json['address'] as String?,
        dob: json['dob'] as String?,
        gender: json['gender'] as String?,
        phone: json['phone'] as String?,
        specialName: json['specialName'] as String?,
        experience: json['experience'] as int?,
        rating: json['rating'] == null ? 0.0 : json['rating'].toDouble());
  }

  ConsultantSpecModel.general(
      {required this.consultantId,
      required this.name,
      required this.imageUrl,
      required this.gender,
      required this.experience,
      required this.address,
      required this.rating})
      : specialName = '',
        email = '',
        dob = '',
        phone = '';

  factory ConsultantSpecModel.fromGeneralJson(Map<String, dynamic> json) {
    return ConsultantSpecModel.general(
      consultantId: json['consultantId'] as int,
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
      gender: json['gender'] as String?,
      address: json['address'] as String?,
      experience: json['experience'] as int?,
      rating: json['rating'] == null ? 0.0 : json['rating'].toDouble(),
    );
  }
}
