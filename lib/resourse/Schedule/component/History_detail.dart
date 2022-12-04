import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/model/History.dart';
import 'package:astrology/reponsitory/History_.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HisDetailPage extends StatefulWidget {
  int slotId;
  String? imageUrl;
  String? consulName;

  HisDetailPage({
    required this.slotId,
    required this.imageUrl,
    required this.consulName,
  });

  @override
  State<HisDetailPage> createState() => _HisDetailPageState();
}

class _HisDetailPageState extends State<HisDetailPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:
          TopBar.getAppBarHasBackIcon(size, context, 'Chi tiết cuộc hẹn', () {
        Navigator.pop(context);
      }),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Color(0xff17384e),
          child: Column(
            children: [
              Center(
                child: Container(
                  height: size.height * 0.25,
                  width: size.width * 0.45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        image: NetworkImage(widget.imageUrl!),
                        fit: BoxFit.fill,
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Chuyên gia:' + widget.consulName!,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
              Container(
                height: 600,
                width: 500,
                child: FutureBuilder<HistoryModel>(
                  future: fetchHistory(widget.slotId),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('something went wrong!!',
                            style: TextStyle(color: Colors.black)),
                      );
                    } else if (snapshot.hasData) {
                      return ShowDetail(item: snapshot.data!);
                    } else {
                      return Container(
                          height: size.height,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShowDetail extends StatelessWidget {
  HistoryModel item;
  ShowDetail({required this.item});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Center(
            //   child: Container(
            //     height: size.height * 0.25,
            //     width: size.width * 0.45,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(20.0),
            //         image: DecorationImage(
            //           image: NetworkImage(widget.imageUrl!),
            //           fit: BoxFit.fill,
            //         )),
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),

            // Text(
            //   'Chuyên gia:' + widget.consultantName!,
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontWeight: FontWeight.bold,
            //     fontSize: 25.0,
            //   ),
            // ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Thời gian bắt đầu : ' + item.timeStart!,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Thời gian kết thúc :' + item.timeEnd!,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Giá : ' + item.price.toString() + ' Gem',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(
              height: 10.0,
            ),
            Text(
              'Trạng thái : ' + item.status!,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            item.reasonOfCustomer == null
                ? Text(
                    'Thời gian hủy : ' + item.reasonOfConsultant!,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text(
                    'Thời gian hủy : ' + item.reasonOfCustomer!,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
