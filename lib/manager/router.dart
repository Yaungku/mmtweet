import 'package:mmtweet/ui/maintab.dart';
import 'package:mmtweet/ui/pages/createnew.dart';
import 'package:mmtweet/ui/pages/home.dart';
import 'package:mmtweet/ui/pages/login.dart';
import 'package:mmtweet/ui/pages/myRestore.dart';
import 'package:mmtweet/ui/pages/register.dart';

var appRoutes = {
  HomePage.routeName: (context) => HomePage(),
  LoginPage.routeName: (context) => LoginPage(),
  RegisterPage.routeName: (context) => RegisterPage(),
  CreateNewPage.routeName: (context) => CreateNewPage(),
  MyRestore.routeName: (context) => MyRestore(),
  MainTab.routeName: (context) => MainTab(),
};
