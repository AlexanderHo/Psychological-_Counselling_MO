
class NewUserModel{
  final int id;
  final String name;
  final String email;

  NewUserModel({required this.id,required this.name,required this.email});


  factory NewUserModel.fromJson(Map<String,dynamic>json){
    return NewUserModel(
      id: json['id'] as int,
      name: json['userName'] as String,
      email: json['email']as String,
    );
  }
}
