import 'package:astrology/model/Deposit_model.dart';
import 'package:astrology/reponsitory/deposit_.dart';
import 'package:astrology/resourse/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MomoPage extends StatefulWidget {
  TextEditingController amount;
  MomoPage({required this.amount});

  @override
  State<MomoPage> createState() => _MomoPageState();
}

class _MomoPageState extends State<MomoPage> {
  late Future<DepositModel> deposit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    deposit = getDeposit(widget.amount);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 15.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          constraints:
              BoxConstraints(minHeight: size.height, minWidth: size.width),
          padding: EdgeInsets.fromLTRB(15.0, size.height * 0.1, 15.0, 0.0),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background/background1.png'),
                  fit: BoxFit.fill)),
          child: FutureBuilder<DepositModel>(
            future: deposit,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('something went wrong!!',
                      style: TextStyle(color: Colors.white)),
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
      ),
    );
  }
}

class ShowDetail extends StatelessWidget {
  DepositModel item;
  ShowDetail({required this.item});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: size.height * 0.5,
            width: size.width * 0.855,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(item.qrcodemomo!),
              fit: BoxFit.fill,
            )),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            'Số Gem nạp : ' + item.amount.toString(),
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Chủ tk : ' + item.name!,
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Số đt : ' + item.phonenumber!,
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          // Html(
          //   data: item.description,
          //   style: {
          //     "strong": Style(
          //       color: Colors.white,
          //       fontSize: FontSize.larger,
          //     ),
          //     "p": Style(
          //       color: Colors.white70,
          //       fontSize: FontSize.large,
          //     ),
          //   },
          // ),
          // SizedBox(
          //   height: 15.0,
          // ),
          // Container(
          //   padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
          //   child: Html(
          //     data: item.mainContent,
          //     style: {
          //       "strong": Style(
          //         color: Colors.white,
          //         fontSize: FontSize.larger,
          //       ),
          //       "p": Style(
          //         color: Colors.white70,
          //         fontSize: FontSize.large,
          //       ),
          //     },
          //   ),
          // ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
                Fluttertoast.showToast(
                    msg: "Vui Lòng chờ xác nhận trong ít phút",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Color.fromARGB(255, 44, 194, 6),
                    textColor: Colors.black,
                    fontSize: 16.0);
              },
              child: Text(
                'XÁC NHẬN',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
