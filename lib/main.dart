import 'package:flutter/material.dart';
import 'package:librarymanagementsystem/screens/admin/admin_login.dart';
import 'package:librarymanagementsystem/screens/admin/admin_page.dart';
import 'package:librarymanagementsystem/screens/student/login_page.dart';
import 'package:librarymanagementsystem/screens/student/registration_page.dart';
import 'package:librarymanagementsystem/screens/student/student.dart';
import 'package:librarymanagementsystem/screens/welcome_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomePage.id,
      routes: {
        WelcomePage.id: (context) => WelcomePage(),
        RegistrationPage.id: (context) => RegistrationPage(),
        LoginPage.id: (context) => LoginPage(),
        AdminLogin.id: (context) => AdminLogin(),
        Student.id: (context) => Student(),
        AdminPage.id: (context) => AdminPage(),
      },
    );
  }
}
