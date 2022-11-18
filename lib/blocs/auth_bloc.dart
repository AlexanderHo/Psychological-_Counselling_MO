import 'package:astrology/blocs/auth_events.dart';
import 'package:astrology/blocs/auth_state.dart';
import 'package:astrology/reponsitory/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  AuthRepo repo;
  AuthBloc(AuthState initialState, this.repo) : super(initialState);

  @override
  Stream<AuthState> mapEventToState(AuthEvents event) async* {
    var pref = await SharedPreferences.getInstance();
    if (event is StartEvent) {
      yield LoginInitState();
    } else if (event is LoginBottonPressed) {
      yield LoginLoadingState();
      var data = await repo.login(event.userName, event.password);
      if (data['message'] == "Login with role customer successful") {
        pref.setInt("idcustomer", data['idcustomer']);
        yield CustomerLoginSuccessState();
      } else if (data['message'] == "Login with role consultant successful") {
        pref.setInt("idconsultant", data['idconsultant']);
        yield ConsultantLoginSuccessState();
      } else {
        yield LoginErrorState(message: "auth problem");
      }
    }
  }
}
