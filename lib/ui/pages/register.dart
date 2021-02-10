import 'package:flutter/material.dart';
import 'package:mmtweet/manager/constant.dart';
import 'package:mmtweet/manager/storage.dart';
import 'package:mmtweet/ui/wigets/space.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';

import 'myRestore.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/register';
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nrcController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool restored = StorageManager.localStorage.getItem(mrestore) ?? false;
    print(restored);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Register",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              space10(),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Name';
                  }
                  return null;
                },
                controller: nameController,
                decoration: InputDecoration(
                    labelText: "Enter User Name",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10)),
              ),
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
                    labelText: "Enter Phone No",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10)),
              ),
              space10(),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Email';
                  }
                  return null;
                },
                controller: emailController,
                decoration: InputDecoration(
                    labelText: "Enter Email",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10)),
              ),
              space10(),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter NRC';
                  }
                  return null;
                },
                controller: nrcController,
                decoration: InputDecoration(
                    labelText: "Enter NRC",
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
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Enter Password",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10)),
              ),
              space20(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: RegisterButton(
                  nameController,
                  phoneController,
                  emailController,
                  nrcController,
                  passwordController,
                  _formKey,
                ),
              ),
              FlatButton(
                child: Text("Restore"),
                //color: Color.fromARGB(255, 240, 108, 155),
                onPressed: () =>
                    Navigator.pushNamed(context, MyRestore.routeName),
              ),
              Center(
                child: restored ? Text("Key restored") : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterButton extends StatefulWidget {
  final nameController;
  final phoneController;
  final emailController;
  final passwordController;
  final nrcController;
  final formkey;

  RegisterButton(
      this.nameController,
      this.phoneController,
      this.emailController,
      this.nrcController,
      this.passwordController,
      this.formkey);

  @override
  _RegisterButtonState createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {
  String accountId;
  String secretSeed;

  void createKey() {
    KeyPair pair = KeyPair.random();
    setState(() {
      accountId = pair.accountId;
      secretSeed = pair.secretSeed;
    });
    print("Account Id  : " + pair.accountId);
    print("Secret Seed : " + pair.secretSeed);
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      textColor: Colors.white,
      color: iconcolor,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(100.0),
      ),
      onPressed: () {
        if (widget.formkey.currentState.validate()) {
          if (!(keyExist())) {
            createKey();
            StorageManager.localStorage.setItem(mprivateKey, secretSeed);
            StorageManager.localStorage.setItem(mpublicKey, accountId);
          } // Skip this if restore state flag is true.

          StorageManager.localStorage
              .setItem(mname, widget.nameController.text);
          StorageManager.localStorage
              .setItem(mphone, widget.phoneController.text);
          StorageManager.localStorage
              .setItem(memail, widget.emailController.text);
          StorageManager.localStorage
              .setItem(mpassword, widget.passwordController.text);
          StorageManager.localStorage.setItem(mnrc, widget.nrcController.text);
          Navigator.pop(context);
        } else {
          print("Form is Empty");
        }
      },
      child: Text("Confirm"),
    );
  }
}

bool keyExist() {
  return (StorageManager.localStorage.getItem(mprivateKey) is String) &&
      (StorageManager.localStorage.getItem(mpublicKey) is String);
}
