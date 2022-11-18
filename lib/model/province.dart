class Province{
  final String name;
  Province({required this.name});
  factory Province.formJson(Map<String, dynamic> json){
    return Province(name: json['name']);
  }
}