import 'dart:async';

import 'package:astrology/model/notification_model.dart';
import 'package:astrology/reponsitory/current_user_shared_preferences.dart';
import 'package:astrology/reponsitory/notification_.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class notificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<notificationPage> {
  int customerId = CurrentUser.getUserId() ?? 0;
  String name = CurrentUser.getCurrentUserName() ?? '';
  late Timer _timer;
  late Future<List<NotiModel>> noti = fetchNotiData(customerId);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reloadPage();
  }

  void reloadPage() {
    _timer = Timer(const Duration(seconds: 5), () {
      setState(() {
        noti = fetchNotiData(customerId);
        print("huy");
        reloadPage();
      });
    });
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _timer.cancel();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
        child: FutureBuilder<List<NotiModel>>(
          future: noti,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Chua co thong bao'),
              );
            } else if (snapshot.hasData) {
              return NotiList(NotiModels: snapshot.data!);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: Colors.purple,
      title: Container(child: Text('Thông Báo')),
    );
  }
}

class NotiList extends StatelessWidget {
  const NotiList({Key? key, required this.NotiModels}) : super(key: key);
  final List<NotiModel> NotiModels;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: NotiModels.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                SeenNoti(NotiModels[index].id);
              },
              onLongPress: () {
                HiddenNoti(NotiModels[index].id);
              },
              child: NotiItem(
                item: NotiModels[index],
              ));
        });
  }
}

class NotiItem extends StatelessWidget {
  NotiModel item;
  NotiItem({required this.item});

  @override
  Widget build(BuildContext context) {
    DateFormat formatTime = DateFormat('HH:mm');
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black54),
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.green.shade50,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 3, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 5.0, bottom: 3, right: 5),
                  child: Container(
                    height: 50,
                    width: 50,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade500,
                    ),
                    child: Icon(
                      Icons.notifications,
                      size: 30,
                      color: Colors.yellow[500],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Thông báo xác nhận',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        item.description,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: item.status == "notseen"
                          ? Colors.green
                          : Colors.grey),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
