import 'package:flutter/material.dart';
import 'package:librarymanagementsystem/screens/admin/admin_home_page.dart';
import 'package:librarymanagementsystem/screens/admin/admin_update.dart';
import 'package:librarymanagementsystem/screens/admin/deleteBook.dart';
import 'package:librarymanagementsystem/screens/admin/deleteStudent.dart';
import 'package:librarymanagementsystem/screens/admin/issueBook.dart';
import 'package:librarymanagementsystem/screens/admin/newBook.dart';
import 'package:librarymanagementsystem/screens/admin/newStudent.dart';
import 'package:librarymanagementsystem/screens/admin/returnBook.dart';
import 'package:librarymanagementsystem/screens/admin/show_book.dart';
import 'package:librarymanagementsystem/screens/admin/updateBook.dart';
import 'package:librarymanagementsystem/screens/welcome_page.dart';
import 'package:librarymanagementsystem/screens/user/user_login.dart';
import 'package:librarymanagementsystem/screens/user/user_register.dart';
import 'package:librarymanagementsystem/screens/user/user_page.dart';
import 'package:librarymanagementsystem/screens/user/user_profile.dart';
import 'package:librarymanagementsystem/screens/user/user_issued_books.dart';
import 'package:librarymanagementsystem/screens/user/search_page.dart';
import 'package:librarymanagementsystem/screens/admin/admin_login.dart';
import 'package:librarymanagementsystem/screens/admin/admin_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomePage.id,
      routes: {
        WelcomePage.id: (context) => WelcomePage(),
        UserLogin.id: (context) => UserLogin(),
        UserRegister.id: (context) => UserRegister(),
        UserPage.id: (context) => UserPage(),
        UserProfile.id: (context) => UserProfile(),
        UserIssuedBooks.id: (context) => UserIssuedBooks(),
        SearchPage.id: (context) => SearchPage(),
        AdminHomePage.id: (context) => AdminHomePage(),
        AdminLogin.id: (context) => AdminLogin(),
        AdminPage.id: (context) => AdminPage(),
        AdminUpdate.id: (context) => AdminUpdate(),
        ShowBook.id: (context) => ShowBook(),
        IssueBook.id: (context) => IssueBook(),
        ReturnBook.id: (context) => ReturnBook(),
        NewStudent.id: (context) => NewStudent(),
        DeleteStudent.id: (context) => DeleteStudent(),
        NewBook.id: (context) => NewBook(),
        UpdateBook.id: (context) => UpdateBook(),
        DeleteBook.id: (context) => DeleteBook(),
      },
    );
  }
}
