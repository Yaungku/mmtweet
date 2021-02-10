import 'package:flutter/material.dart';
import 'package:mmtweet/manager/router.dart';
import 'package:mmtweet/manager/storage.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.camera.request();
  await StorageManager.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'Wepay Wallet',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.blueAccent, //240,108,155
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: appRoutes,
        initialRoute: '/',
      ),
    );
  }
}
