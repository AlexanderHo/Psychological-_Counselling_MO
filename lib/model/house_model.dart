class HouseModel {
  final int id;
  final String? imageUrl;
  final String name;
  final String? element;
  final String tag;
  final String? description;
  final String? mainContent;

  HouseModel(
      {required this.id,
      required this.imageUrl,
      required this.name,
      required this.element,
      required this.tag,
      required this.description,
      required this.mainContent});

  factory HouseModel.fromJson(Map<String, dynamic> json) {
    return HouseModel(
      id: json['id'] as int,
      imageUrl: json['imageUrl'] as String?,
      name: json['name'] as String,
      element: json['element'] as String?,
      tag: json['tag'] as String,
      description: json['description'] as String?,
      mainContent: json['maincontent'] as String?,
    );
  }

  HouseModel.general(
      {required this.id, required this.name, required this.imageUrl})
      : element = '',
        tag = '',
        description = '',
        mainContent = '';

  factory HouseModel.fromGeneralJson(Map<String, dynamic> json) {
    return HouseModel.general(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
    );
  }
}
