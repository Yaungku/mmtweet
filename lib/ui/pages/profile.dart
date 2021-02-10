import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:mmtweet/manager/constant.dart';
import 'package:mmtweet/manager/storage.dart';
import 'package:mmtweet/ui/pages/createnew.dart';
import 'package:mmtweet/ui/wigets/appbar.dart';
import 'package:mmtweet/ui/wigets/space.dart';
import 'package:oktoast/oktoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // String publickey = StorageManager.localStorage.getItem(mpublicKey);
  // String name = StorageManager.localStorage.getItem(mname);
  // String email = StorageManager.localStorage.getItem(memail);
  // String phno = StorageManager.localStorage.getItem(mphone);
  // String nrc = StorageManager.localStorage.getItem(mnrc);
  double verticalpadding = 5;
  String publickey = "111";
  String name = "Namwe";
  String email = "mail";
  String phno = "Phone";
  String nrc = "hjwhjhw";

  String info;

  bool accActivated = false;

  getInfo() {
    String name = StorageManager.localStorage.getItem(mname);
    String email = StorageManager.localStorage.getItem(memail);
    String phno = StorageManager.localStorage.getItem(mphone);
    String nrc = StorageManager.localStorage.getItem(mnrc);
    setState(() {
      info =
          "Name: $name \n Email: $email \n Phone: $phno \n NRC: $nrc \n Account: $publickey";
    });
  }

  revealSecret() {
    TextEditingController secretcontroller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Reveal Secret"),
          content: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: TextField(
              obscureText: true,
              controller: secretcontroller,
              decoration: InputDecoration(
                hintText: "Enter Password",
              ),
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            FlatButton(
              onPressed: () {
                String pasword = StorageManager.localStorage.getItem(mpassword);
                if (secretcontroller.text == pasword) {
                  Navigator.pop(context);
                  secretDialog();
                } else {
                  Navigator.pop(context);
                  showToast("Your Password is wrong");
                }
              },
              child: Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  secretDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String secert = StorageManager.localStorage.getItem(mprivateKey);
        return AlertDialog(
          title: Text("Your Secret"),
          content: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(secert),
                space10(),
                Text(
                    "Note: Do not show or lost your secret. This can be used to recover your Acc"),
              ],
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                FlutterClipboard.copy(secert).then((value) {
                  showToast("Copy to Clipboard");
                  Navigator.pop(context);
                });
              },
              child: Text("Copy"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getAccountDetails(
        "GBQ6KZVFJYWP2NLTGOKWZRQ7AFQI6B4AUXP5GLZ6QNEM4UBT6633KCPN");
  }

  Future<void> createTrustline(String asset, String limit) async {
    String userSecretSeed = StorageManager.localStorage.getItem(mprivateKey);
    KeyPair trustorKeyPair = KeyPair.fromSecretSeed(userSecretSeed);
    AccountResponse trustor =
        await sdk.accounts.account(trustorKeyPair.accountId);
    // KeyPair issuerKeypair = KeyPair.fromAccountId(agentAccountId);
    Asset assetType = Asset.createNonNativeAsset(asset, issureAcc);

    ChangeTrustOperationBuilder changeTrustOperation =
        ChangeTrustOperationBuilder(assetType, limit);

    Transaction transaction = new TransactionBuilder(trustor)
        .addOperation(changeTrustOperation.build())
        .build();
    transaction.sign(trustorKeyPair, net);

    try {
      await sdk.submitTransaction(transaction);
      print("Success");
    } catch (e) {
      print("something went wrong. on creating trustline");
    }
  }

  Future<void> getAccountDetails(String accountId) async {
    try {
      await sdk.accounts.account(accountId).then((account) async {
        Balance native = account.balances[0];
        if (native.assetIssuer == null) {
          await createTrustline(iom, limit);
          getAccountDetails(accountId);
        } else {
          setState(() {
            accActivated = true;
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            space20(),
            Center(
              child: Container(
                height: 150,
                width: 150,
                child: QrImage(
                  data: publickey,
                  version: QrVersions.auto,
                  size: 150.0,
                ),
              ),
            ),
            space10(),
            Center(
              child: Text(
                name,
                style: TextStyle(fontSize: 24),
              ),
            ),
            space20(),
            accActivated
                ? Container()
                : Center(
                    child: Text("Account is not acctivated"),
                  ),
            space20(),
            accActivated
                ? Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateNewPage(),
                          ),
                        );
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: verticalpadding),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(iconradius),
                        ),
                        child: Center(
                          child: Text(
                            "Tweet",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            space10(),
            Center(
              child: GestureDetector(
                onTap: () {
                  print(publickey);
                  FlutterClipboard.copy(publickey).then(
                    (value) => showToast("Copy to Clipboard"),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: verticalpadding),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(iconradius),
                  ),
                  child: Center(
                    child: Text(
                      "Copy",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            space10(),
            Center(
              child: GestureDetector(
                onTap: () {
                  getInfo();
                  print(info);
                  FlutterClipboard.copy(info).then(
                    (value) => showToast("Copy to Clipboard"),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: verticalpadding),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(iconradius),
                  ),
                  child: Center(
                    child: Text(
                      "Share",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            space10(),
            Center(
              child: GestureDetector(
                onTap: () {
                  revealSecret();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: verticalpadding),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(iconradius),
                  ),
                  child: Center(
                    child: Text(
                      "Reveal Secret",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
