import 'package:flutter/material.dart';
import 'package:mmtweet/manager/constant.dart';
import 'package:mmtweet/manager/storage.dart';
import 'package:mmtweet/ui/wigets/space.dart';
import 'package:oktoast/oktoast.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';

class CreateNewPage extends StatefulWidget {
  static const routeName = '/profile/tweet';
  @override
  _CreateNewPageState createState() => _CreateNewPageState();
}

class _CreateNewPageState extends State<CreateNewPage> {
  TextEditingController newController = TextEditingController();

  Future<void> uploadNew(String memo) async {
    showToast("Processing Please Wait");
    print(memo);
    Navigator.pop(context);
    // need to add assetype
    String assetype = '';
    print("Type: $assetype");
    String senderSecret = StorageManager.localStorage.getItem(mprivateKey);
    KeyPair senderKeyPair = KeyPair.fromSecretSeed(senderSecret);
    Asset assetType = Asset.createNonNativeAsset(assetype, issureAcc);
    AccountResponse sender =
        await sdk.accounts.account(senderKeyPair.accountId);

    Transaction transaction = new TransactionBuilder(sender)
        .addOperation(PaymentOperationBuilder(mainAcc, assetType, '1').build())
        .addMemo(Memo.text(memo))
        .build();
    transaction.sign(senderKeyPair, net);
    try {
      await sdk.submitTransaction(transaction);
      print("Successfully uploaded");
      showToast("Success");
    } catch (e) {
      showToast("Something wrong with uploading New");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        //automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Create New",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: ListView(
          children: [
            space20(),
            TextField(
              maxLength: maxmemolength,
              maxLengthEnforced: true,
              controller: newController,
              decoration: InputDecoration(
                hintText: "Enter New",
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            space20(),
            Center(
              child: FlatButton(
                onPressed: () {
                  if ((newController.text.length) > maxmemolength) {
                    showToast("The New is long");
                  } else {
                    uploadNew(newController.text);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: iconcolor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: Text(
                    "Transfer",
                    style: TextStyle(color: Colors.white),
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
