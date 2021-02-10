import 'package:flutter/material.dart';
import 'package:mmtweet/manager/constant.dart';
import 'package:mmtweet/manager/storage.dart';
import 'package:mmtweet/ui/maintab.dart';
import 'package:mmtweet/ui/pages/home.dart';
import 'package:mmtweet/ui/pages/register.dart';
import 'package:mmtweet/ui/wigets/appbar.dart';
import 'package:mmtweet/ui/wigets/space.dart';
import 'package:oktoast/oktoast.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final loginkey = GlobalKey<FormState>();
    TextEditingController phoneController = TextEditingController();
    TextEditingController passowordController = TextEditingController();

    return Scaffold(
      appBar: AppbarWidget(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
        child: Form(
          key: loginkey,
          child: Container(
            child: ListView(
              children: <Widget>[
                space10(),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Phone No';
                    }
                    return null;
                  },
                  controller: phoneController,
                  decoration: InputDecoration(
                      labelText: "Phone No",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                ),
                space10(),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Password';
                    }
                    return null;
                  },
                  controller: passowordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Password",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                ),
                space40(),
                RaisedButton(
                  textColor: Colors.white,
                  color: iconcolor,
                  child: Text("Login"),
                  onPressed: () {
                    if (loginkey.currentState.validate()) {
                      String publickey =
                          StorageManager.localStorage.getItem(mpublicKey);
                      String phone =
                          StorageManager.localStorage.getItem(mphone);
                      String password =
                          StorageManager.localStorage.getItem(mpassword);
                      if (publickey != null) {
                        if (phone == phoneController.text &&
                            password == passowordController.text) {
                          Navigator.pushReplacementNamed(
                              context, MainTab.routeName);
                        } else {
                          showToast("Phone or Password are incorrect");
                        }
                      } else {
                        showToast("Please Register");
                      }
                    } else {
                      showToast("Phone and Password are empty");
                    }
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(100.0),
                  ),
                ),
                // FlatButton(
                //     child: Text("Login as Agent"),
                //     //color: Color.fromARGB(255, 240, 108, 155),
                //     onPressed: () {
                //       StorageManager.localStorage.setItem(magent, true);
                //       Navigator.pushReplacementNamed(
                //           context, HomePage.routeName);
                //     }),
                FlatButton(
                  child: Text("Register"),
                  //color: Color.fromARGB(255, 240, 108, 155),
                  onPressed: () =>
                      Navigator.pushNamed(context, RegisterPage.routeName),
                ),
                // FlatButton(
                //   child: Text("Home"),
                //   //color: Color.fromARGB(255, 240, 108, 155),
                //   onPressed: () => Navigator.pushReplacementNamed(
                //       context, MainTab.routeName),
                // ),

                space40(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
