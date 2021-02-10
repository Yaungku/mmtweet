import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mmtweet/manager/constant.dart';
import 'package:mmtweet/model/transitionModel.dart';
import 'package:mmtweet/ui/wigets/appbar.dart';
import 'package:mmtweet/ui/wigets/space.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:timeago/timeago.dart' as timeago;

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<Transition> transitionlist = [];
  bool _isPageLoading = true;
  final DateFormat formatter = DateFormat.yMEd();

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    await Future.wait([
      getdatawithAcc(),
    ], eagerError: true)
        .then((value) {
      setState(() {
        _isPageLoading = false;
      });
    });
  }

  //testing local data
  Future loadJson() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString('assets/json/account.json');
    var jsonResult = json.decode(data);
    var results = jsonResult['_embedded']['records']
        .map<Transition>((item) => Transition.fromJson(item))
        .toList();
    List<Transition> filtered = [];
    for (int i = 0; i < results.length; i++) {
      if (results[i].memo != null) {
        filtered.add(results[i]);
      }
    }
    setState(() {
      transitionlist = filtered;
    });
  }

  //getting data from public network
  Future getdata() async {
    try {
      var uriResponse = await http.get(alltransition);
      var jsonResult = json.decode(uriResponse.body);
      var results = jsonResult['_embedded']['records']
          .map<Transition>((item) => Transition.fromJson(item))
          .toList();
      List<Transition> filtered = [];
      for (int i = 0; i < results.length; i++) {
        if (results[i].memo != null) {
          filtered.add(results[i]);
        }
      }
      setState(() {
        transitionlist = filtered;
      });
    } catch (e) {
      showToast(e);
    }
  }

  Future getdatawithAcc() async {
    try {
      var uriResponse = await http.get(transitionurl);
      var jsonResult = json.decode(uriResponse.body);
      var results = jsonResult['_embedded']['records']
          .map<Transition>((item) => Transition.fromJson(item))
          .toList();
      List<Transition> filtered = [];
      for (int i = 0; i < results.length; i++) {
        if (results[i].memo != null) {
          filtered.add(results[i]);
        }
      }
      setState(() {
        transitionlist = filtered;
      });
    } catch (e) {
      showToast(e);
    }
  }

  void _onRefresh() async {
    // await loadJson();
    await Future.delayed(Duration(milliseconds: 1000));
    // await getdata();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await getdatawithAcc();
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  loadingWidget() {
    return SpinKitRotatingCircle(color: iconcolor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(),
      body: SmartRefresher(
        enablePullDown: true,
        header: WaterDropHeader(),
        onRefresh: () {
          _onRefresh();
        },
        onLoading: () {
          _onLoading();
        },
        controller: _refreshController,
        child: (_isPageLoading || transitionlist.isEmpty)
            ? loadingWidget()
            : ListView.builder(
                itemCount: transitionlist.length,
                itemBuilder: (context, index) {
                  Transition transition = transitionlist[index];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          transition.memo,
                          style: TextStyle(fontSize: 20.0),
                        ),
                        trailing: Text(
                          timeago.format(
                            DateTime.parse(transition.created),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                        height: 1,
                      )
                    ],
                  );
                },
              ),
      ),
    );
  }
}
