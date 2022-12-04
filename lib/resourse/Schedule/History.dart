import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/Components/bottom_bar.dart';
import 'package:astrology/model/Slot_model.dart';
import 'package:astrology/reponsitory/booking_.dart';
import 'package:astrology/reponsitory/current_user_shared_preferences.dart';
import 'package:astrology/reponsitory/slot_.dart';
import 'package:astrology/resourse/Schedule/component/History_detail.dart';
import 'package:astrology/resourse/app_router.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

TextEditingController? feedback = TextEditingController();
TextEditingController? rate = TextEditingController();

class _HistoryPageState extends State<HistoryPage> {
  int customerId = CurrentUser.getUserId() ?? 0;
  DateTime? date = DateTime.now();
  DateFormat formatDate = DateFormat('yyyy-MM-dd');
  String _date = '';

  DateTime? _selectedDay;
  late Future<List<SlotModel>> his;
  @override
  void initState() {
    his = fetchSlotHis(customerId, _date = formatDate.format(date!));
    super.initState();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 31)),
      lastDate: DateTime.now(),
    ).then((value) {
      setState(() {
        date = value!;
        his = fetchSlotHis(customerId, _date = formatDate.format(date!));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopBar.getAppBarHome(size, context),
      body: Container(
        color: Color(0xff17384e),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                  height: 70,
                  color: Colors.blue.shade50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Ngày ' +
                                    '${date!.day} ' +
                                    'tháng ' +
                                    '${DateFormat.M().format(date!)} ' +
                                    'năm ' +
                                    '${DateFormat.y().format(date!)} ',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 25.0),
                              ),
                              // Text(
                              //   '${date!.day}',
                              //   style: TextStyle(
                              //       fontStyle: FontStyle.normal, fontSize: 20.0),
                              // ),
                              // Text(
                              //   '${DateFormat.EEEE().format(date!)}',
                              //   style: TextStyle(
                              //       fontStyle: FontStyle.normal, fontSize: 20.0),
                              // )
                            ],
                          ),
                        ),
                      )),
                      GestureDetector(
                        onTap: _showDatePicker,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child:
                                Icon(Icons.calendar_month, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  )),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 600,
                    width: 500,
                    child: FutureBuilder<List<SlotModel>>(
                      future: his,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Something went wrong!!'),
                          );
                        } else if (snapshot.hasData) {
                          return SlotList(SlotModels: snapshot.data!);
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xff031d2e),
        child: BottomBar(selected: "History"),
      ),
    );
  }
}

class SlotList extends StatelessWidget {
  const SlotList({Key? key, required this.SlotModels}) : super(key: key);

  final List<SlotModel> SlotModels;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: SlotModels.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {},
              child: slotItem(
                item: SlotModels[index],
              ));
        });
  }
}

class slotItem extends StatelessWidget {
  SlotModel item;
  slotItem({required this.item});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateFormat formatTime = DateFormat('HH:mm');
    TextEditingController? reason = TextEditingController();
    final _reasonKey = GlobalKey<FormState>();

    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(15.0),
          color: item.status == "cancel" || item.status == "overdue"
              ? Colors.red[200]
              : Colors.green.shade50,
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
                    border: Border.all(color: Colors.white),
                    image: DecorationImage(
                      image: NetworkImage(item.imageUrl!),
                    )),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.consultantName!,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 18.0,
                        ),
                      ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      // Text(
                      //   'Chủ đề' + item.description!,
                      //   style: TextStyle(
                      //     color: Colors.black87,
                      //     fontWeight: FontWeight.w400,
                      //     fontSize: 18.0,
                      //   ),
                      // ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${formatTime.format(_convertStringToDateTime(item.timeStart!)!)}',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                            ),
                          ),
                          Text(
                            '-' +
                                '${formatTime.format(_convertStringToDateTime(item.timeEnd!)!)}',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // item.status=="cancel" ? return null :
                          Container(
                            height: 15,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.red[200]),
                            child: ElevatedButton(
                              onPressed: () {
                                if (item.status == "cancel" ||
                                    item.status == "overdue") {
                                  return null;
                                }
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text('Thông báo'),
                                          content: Text(
                                              'Vui Lòng đánh giá cuộc hẹn này'),
                                          actions: <Widget>[
                                            Form(
                                              key: _reasonKey,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller: feedback,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            'Nhập cảm nhận của bạn...'),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Vui lòng nhập cảm nhận...';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    controller: rate,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            'Nhập rating của bạn...'),
                                                    validator: (value) {
                                                      if (int.parse(value!) <
                                                              0 ||
                                                          int.parse(value!) >
                                                              6) {
                                                        return 'Rating từ 1 đến 5';
                                                      } else if (value ==
                                                              null ||
                                                          value.isEmpty) {
                                                        return 'Vui lòng nhập rating...';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 3),
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        if (_reasonKey
                                                            .currentState!
                                                            .validate()) {
                                                          FeedBack(
                                                              item.bookingId!,
                                                              feedback!,
                                                              int.parse(
                                                                  rate!.text));

                                                          Navigator.pop(context,
                                                              'Xác nhận');
                                                        }
                                                      },
                                                      child: const Text(
                                                          'Xác nhận')),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 3),
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, 'Hủy');
                                                      },
                                                      child: const Text('Hủy')),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ));
                                // Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                item.status == "cancel" ||
                                        item.status == "overdue"
                                    ? Colors.grey[400]
                                    : Colors.red[400],
                              )),
                              child: const Text(
                                "Đánh giá",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                          Container(
                            height: 15,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.green.shade300,
                            ),
                            child: OutlinedButton(
                              onPressed: () {
                                AppRouter.push(HisDetailPage(
                                  slotId: item.id,
                                  imageUrl: item.imageUrl,
                                  consulName: item.consultantName,
                                ));
                              },
                              child: Text(
                                'chi tiết',
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
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
