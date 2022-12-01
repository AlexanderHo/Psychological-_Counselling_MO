import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/model/Daily_model.dart';
import 'package:astrology/reponsitory/Daily_.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DailyHocroscopePage extends StatefulWidget {
  const DailyHocroscopePage({super.key});

  @override
  State<DailyHocroscopePage> createState() => _DailyHocroscopePageState();
}

class _DailyHocroscopePageState extends State<DailyHocroscopePage> {
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();

  final format = DateFormat('yyyy-MM-dd');
  DateTime? _selectedDay;
  late Future<DailyModel> daily;
  void initState() {
    daily = fetchDailyData(format.format(_focusedDay));
    super.initState();
    print(_focusedDay);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:
          TopBar.getAppBarHasBackIcon(size, context, 'Lá phiếu hằng ngày', () {
        Navigator.pop(context);
      }),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Card(
                child: TableCalendar(
                  // locale: 'us',
                  focusedDay: DateTime.now(),
                  firstDay: DateTime.now(),
                  // firstDay: DateTime.now().subtract(Duration(days: 7)),
                  lastDay: DateTime.now().add(Duration(days: 2)),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      daily = fetchDailyData(format.format(
                          _focusedDay)); // update `_focusedDay` here as well
                      print(format.format(_focusedDay));
                    });
                  },
                  calendarFormat: _calendarFormat,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 800,
                  width: 500,
                  child: FutureBuilder<DailyModel>(
                    future: daily,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Something went wrong!!'),
                        );
                      } else if (snapshot.hasData) {
                        return ShowDetail(item: snapshot.data!);
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
    );
  }
}

class ShowDetail extends StatelessWidget {
  DailyModel item;
  ShowDetail({required this.item});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              height: size.height * 0.25,
              width: size.width * 0.45,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(item.imageUrl!),
                fit: BoxFit.fill,
              )),
            ),
          ),
          Text(
            item.context!,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            'Công việc : ' + item.job!,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Con số mai mắn : ' + item.luckyNumber.toString(),
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Màu hợp : ' + item.color!,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Giờ tốt :' + item.goodTime!,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Việc nên làm :' + item.shouldThing!,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Không nên làm : ' + item.shouldNotThing!,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
