import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/blocs/register_cubit.dart';
import 'package:flutter_application_1/services/shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color(0xFF2454F8),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Home Screen!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => _handleLogout(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text('Logout', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLogout(BuildContext context) async {
    // Clear saved data
    await SharedPreferencesService.clearAll();

    // Trigger logout event
    context.read<AuthBloc>().add(LogoutRequested());

    // Navigate to login screen
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
