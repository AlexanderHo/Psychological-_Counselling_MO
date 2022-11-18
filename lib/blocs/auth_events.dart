import 'package:equatable/equatable.dart';

class AuthEvents extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class StartEvent extends AuthEvents {}

class LoginBottonPressed extends AuthEvents {
  final String userName;
  final String password;
  LoginBottonPressed({required this.userName, required this.password});
}
