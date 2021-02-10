import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmtweet/manager/constant.dart';
import 'package:mmtweet/manager/storage.dart';
import 'package:mmtweet/ui/wigets/space.dart';
import 'package:oktoast/oktoast.dart';

class MyRestore extends StatefulWidget {
  static const routeName = "/myrestore";
  @override
  _MyRestoreState createState() => _MyRestoreState();
}

class _MyRestoreState extends State<MyRestore> {
  final keykey = GlobalKey<FormState>();
  TextEditingController publicController = TextEditingController();
  TextEditingController privateController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (keyExist()) {
      publicController.text = StorageManager.localStorage.getItem(mpublicKey);
      privateController.text = StorageManager.localStorage.getItem(mprivateKey);
    }
  }

  bool keyExist() {
    return (StorageManager.localStorage.getItem(mprivateKey) is String) &&
        (StorageManager.localStorage.getItem(mpublicKey) is String);
  }

  @override
  Widget build(BuildContext context) {
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
          "Restore Account",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: keykey,
          child: ListView(
            children: [
              TextFormField(
                validator: (value) {
                  return value.isEmpty ? 'Please enter Public Key' : null;
                },
                controller: publicController,
                decoration: InputDecoration(
                    labelText: "Public Key",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10)),
              ),
              space10(),
              TextFormField(
                validator: (value) {
                  return value.isEmpty ? 'Please enter Private Key' : null;
                },
                controller: privateController,
                decoration: InputDecoration(
                    labelText: "Private Key",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10)),
              ),
              space20(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: RaisedButton(
                  child: Text("Confirm"),
                  textColor: Colors.white,
                  color: iconcolor,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(100.0),
                  ),
                  onPressed: () {
                    if (publicController.text.length == accountidlength &&
                        privateController.text.length == accountidlength) {
                      StorageManager.localStorage.setItem(mname, null);
                      StorageManager.localStorage.setItem(mphone, null);
                      StorageManager.localStorage.setItem(memail, null);
                      StorageManager.localStorage.setItem(mpassword, null);
                      StorageManager.localStorage.setItem(mnrc, null);
                      StorageManager.localStorage
                          .setItem(mpublicKey, publicController.text);
                      StorageManager.localStorage
                          .setItem(mprivateKey, privateController.text);
                      StorageManager.localStorage.setItem(mrestore, true);
                      Navigator.pop(context, true);
                      showToast("Keys are restored");
                    } else {
                      showToast("Account ID or Secret is missing some keys");
                    }
                  },
                ),
              ),
              FlatButton(
                child: Text("Cancel"),
                //color: Color.fromARGB(255, 240, 108, 155),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
