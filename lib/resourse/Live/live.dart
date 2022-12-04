import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/Components/bottom_bar.dart';
import 'package:astrology/model/Slot_model.dart';
import 'package:astrology/reponsitory/room_.dart';
import 'package:astrology/reponsitory/slot_.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LivePage extends StatelessWidget {
  const LivePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopBar.getAppBarHome(size, context),
      body: Container(
        // constraints:
        //     BoxConstraints(minHeight: size.height, minWidth: size.width),
        // padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //   image: AssetImage('assets/background/anh-sao-bang.jpg'),
        //   fit: BoxFit.fitHeight,
        // )),
        color: Color(0xff17384e),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 600,
                width: 500,
                child: FutureBuilder<List<SlotModel>>(
                  future: fetchStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Something went wrong!!',
                          style: TextStyle(color: Colors.amber),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      return SlotList(slotModels: snapshot.data!);
                    } else if (snapshot.data == null) {
                      return Center(
                        child: Text(
                          'Hiện chư có lịch live !!!',
                          style: TextStyle(color: Colors.amber),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xff031d2e),
        child: BottomBar(selected: "Live"),
      ),
    );
  }
}

class SlotList extends StatelessWidget {
  const SlotList({Key? key, required this.slotModels}) : super(key: key);
  final List<SlotModel> slotModels;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: slotModels.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                fetchLiveStream(slotModels[index].id);
              },
              child: SlotItem(
                item: slotModels[index],
              ));
        });
  }
}

class SlotItem extends StatelessWidget {
  SlotModel item;
  SlotItem({required this.item});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateFormat formatTime = DateFormat('HH:mm');
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.blueGrey[200],
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: size.height * 0.15,
                width: size.width * 0.4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(item.imageUrl!),
                    )),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      item.description!,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      item.consultantName!,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(179, 25, 25, 25),
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      'Thời gian bắt đầu :' +
                          '${formatTime.format(_convertStringToDateTime(item.timeStart!)!)}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(179, 23, 23, 23),
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      'Dự kiến kết thúc : ' +
                          '${formatTime.format(_convertStringToDateTime(item.timeEnd!)!)}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(179, 23, 23, 23),
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  DateTime? _convertStringToDateTime(String time) {
    DateTime? _dateTime;
    try {
      _dateTime = new DateFormat("hh:mm").parse(time);
    } catch (e) {}
    return _dateTime;
  }
}
