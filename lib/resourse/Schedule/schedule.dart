import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/Components/bottom_bar.dart';
import 'package:astrology/model/RoomVideo_model.dart';
import 'package:astrology/model/Slot_model.dart';
import 'package:astrology/reponsitory/current_user_shared_preferences.dart';
import 'package:astrology/reponsitory/room_.dart';
import 'package:astrology/reponsitory/slot_.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentPage extends StatefulWidget {
  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  int customerId = CurrentUser.getUserId() ?? 0;
  DateTime? date = DateTime.now();
  DateFormat formatDate = DateFormat('yyyy-MM-dd');
  String _date = '';

  late Future<List<SlotModel>> slot;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slot = fetchSlotApm(customerId, _date = formatDate.format(date!));
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 31)),
    ).then((value) {
      setState(() {
        date = value!;
        slot = fetchSlotApm(customerId, _date = formatDate.format(date!));
      });
    });
  }

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
        constraints:
            BoxConstraints(minHeight: size.height, minWidth: size.width),
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
                                'Ng??y ' +
                                    '${date!.day} ' +
                                    'th??ng ' +
                                    '${DateFormat.M().format(date!)} ' +
                                    'n??m ' +
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 750,
                  width: 500,
                  child: FutureBuilder<List<SlotModel>>(
                    future: slot,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Something went wrong!!'),
                        );
                      } else if (snapshot.hasData) {
                        return SlotList(SlotModels: snapshot.data!);
                      } else if (snapshot.data == null) {
                        return Center(
                          child: Text(
                            'Hi???n ch??a c?? bu???i h???n!!',
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
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xff031d2e),
        child: BottomBar(selected: "schedule"),
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
  RoomModel? rom;
  late Future<RoomModel> room;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateFormat formatTime = DateFormat('HH:mm');
    TextEditingController? reason = TextEditingController();
    final _reasonKey = GlobalKey<FormState>();
    var formatdate = DateFormat('yyyy-MM-dd');

    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.green.shade50,
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
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Ch??? ?????',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 18.0,
                        ),
                      ),
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
                          Container(
                            height: 25,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.red.shade300,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text('Th??ng b??o'),
                                          content: Text(
                                              'B???n c?? ch???c mu???n h???y l???ch h???n c???a Slot n??y'),
                                          actions: <Widget>[
                                            Form(
                                              key: _reasonKey,
                                              child: TextFormField(
                                                controller: reason,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        'Nh???p l?? do h???y c???a b???n...'),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Vui l??ng nh???p l?? do...';
                                                  }
                                                  return null;
                                                },
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
                                                          CancelBooking(
                                                              reason,
                                                              item.id,
                                                              DateFormat.yMd()
                                                                  .format(DateTime
                                                                      .parse(item
                                                                          .dateSlot!))
                                                                  .toString());
                                                          Navigator.pop(context,
                                                              'X??c nh???n');
                                                        }
                                                      },
                                                      child: const Text(
                                                          'X??c nh???n')),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 3),
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, 'H???y');
                                                      },
                                                      child: const Text('H???y')),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ));
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 213, 57, 57))),
                              child: const Text(
                                "H???y",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                          Container(
                            height: 25,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.green.shade300,
                            ),
                            child: OutlinedButton(
                              onPressed: () {
                                if (_convertStringToDateTime2(formatdate.format(
                                            DateTime.parse(item.dateSlot!)) +
                                        ' ' +
                                        item.timeStart!)!
                                    .subtract(Duration(minutes: 5))
                                    .isBefore(DateTime.now())) {
                                  room = fetchRoom(item.id, item.bookingId!);
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: const Text('Th??ng b??o'),
                                            content: Text(
                                                'B???n ch??? ???????c tham gia ph??ng tr?????c 5 ph??t( th???i gian c?? th??? b???t ?????u v??o ph??ng: ${formatTime.format(_convertStringToDateTime(item.timeStart!)!)})'),
                                            actions: <Widget>[
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, '?????ng ??'),
                                                  child: const Text('?????ng ??'))
                                            ],
                                          ));
                                }
                              },
                              child: Text(
                                'Tham gia',
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

  DateTime? _convertStringToDateTime2(String time) {
    DateTime? _dateTime;
    try {
      _dateTime = new DateFormat('yyyy-MM-dd HH:mm').parse(time);
      // print(_dateTime);
    } catch (e) {}
    return _dateTime;
  }
}
