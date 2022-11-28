class MatchModel {
  final String compatibility;
  final String? zodiaccustomer;
  final String? zodiacprofile;

  MatchModel(
      {required this.compatibility,
      required this.zodiaccustomer,
      required this.zodiacprofile});
  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
        compatibility: json['compatibility'] as String,
        zodiaccustomer: json['zodiaccustomer'] as String?,
        zodiacprofile: json['zodiacprofile'] as String?);
  }
}
