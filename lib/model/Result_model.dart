class ansModel {
  int id;
  List<int> answer;

  ansModel({required this.id, required this.answer});

  Map<String, dynamic> toMap() {
    return {
      'customerId': this.id,
      'optionId': this.answer,
    };
  }

  static dynamic getListMap(List<dynamic> items) {
    if (items == null) {
      return null;
    }
    List<Map<String, dynamic>> list = [];
    items.forEach((element) {
      list.add(element.toMap());
    });
    return list;
  }
}
