import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repositories/auth_repository.dart';
import 'package:flutter_application_1/presentation/blocs/register_cubit.dart';
import 'package:flutter_application_1/presentation/screens/splash_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/register_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/presentation/screens/home_screen.dart';
import 'package:flutter_application_1/presentation/screens/forgot_password_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepository: AuthRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Auth App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(0xFF2454F8),
          fontFamily: 'Roboto',
        ),
        home: SplashScreen(),
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/home': (context) => HomeScreen(),
          '/forgot-password': (context) => ForgotPasswordScreen(),
        },
      ),
    );
  }
}
