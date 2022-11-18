class SpeciaModel {
  final int id;
  final String specname;
  final int specializationTypeId;

  SpeciaModel(
      {required this.id,
      required this.specname,
      required this.specializationTypeId});

  factory SpeciaModel.fromJson(Map<String, dynamic> json) {
    return SpeciaModel(
        id: json['id'] as int,
        specname: json['specname'] as String,
        specializationTypeId: json['specializationTypeId'] as int);
  }
}
