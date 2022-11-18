import 'package:astrology/blocs/auth_bloc.dart';
import 'package:astrology/blocs/auth_state.dart';
import 'package:astrology/reponsitory/auth_repo.dart';
import 'package:astrology/resourse/Call/Components/CallBody.dart';
import 'package:astrology/resourse/Login&register/Register.dart';
import 'package:astrology/resourse/app_router.dart';
import 'package:astrology/resourse/post_contact.dart';
import 'package:astrology/resourse/profile/account.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:astrology/resourse/Login&register/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:astrology/resourse/Home/home.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences.setMockInitialValues({});
//   await Firebase.initializeApp();
//   await CurrentUser();
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) => ChangeNotifierProvider(
//         create: (context) => GoogleSignInProvider(),
//         child: MaterialApp(
//           home: HomePage(),
//         ),
//       );
// }

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (snapshot.hasData) {
//               return BottomBar();
//             } else if (snapshot.hasError) {
//               log(snapshot.error.toString());
//               return Center(
//                 child: Text('Something went wrong'),
//               );
//             } else {
//               return LoginPage();
//             }
//           }),
//     );
//   }
// }

Future<void> _firebaseMessagingBackgroundHandler(message) async {
  await Firebase.initializeApp();
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(Auth());
}

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthBloc(LoginInitState(), AuthRepo())),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/customer': (context) => HomeScreen(),
          '/consultant': (context) => Contact(),
          '/account': (context) => AccountPage(),
          '/call_screen': (context) => BodyCall(),
          '/register': (context) => RegisterPage(),
        },
        navigatorKey: AppRouter.navigatorKey,
      ),
    );
  }
}
