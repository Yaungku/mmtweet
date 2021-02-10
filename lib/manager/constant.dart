import 'package:flutter/material.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';

var net = Network.PUBLIC;
final StellarSDK sdk = StellarSDK.PUBLIC;

const String mname = 'name';
const String mphone = 'phone';
const String memail = 'email';
const String mpassword = 'password';
const String mnrc = 'nrc';
const String mprivateKey = 'publickey';
const String mpublicKey = 'privatekey';
const String magent = 'agent';
const String mrestore = 'restore';

int accountidlength = 56;
int maxmemolength = 32;

Color backgroundcolor = Colors.blue;
Color iconcolor = Colors.black;

String testacc = "GBQ6KZVFJYWP2NLTGOKWZRQ7AFQI6B4AUXP5GLZ6QNEM4UBT6633KCPN";
String mainAcc = "";

String issureAcc = "";

double iconradius = 30;

String alltransition =
    "https://horizon.stellar.org/transactions?limit=10&order=asc&include_failed=true";

String transitionurl =
    "https://horizon.stellar.org/accounts/$testacc/transactions?limit=10&order=asc&include_failed=true";
