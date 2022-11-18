import 'package:astrology/model/Deposit_model.dart';
import 'package:astrology/reponsitory/deposit_.dart';
import 'package:flutter/material.dart';

class BakingPage extends StatefulWidget {
  TextEditingController amount;
  BakingPage({required this.amount});

  @override
  State<BakingPage> createState() => _BakingPageState();
}

class _BakingPageState extends State<BakingPage> {
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
          color: Colors.black54,
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
              image: NetworkImage(item.qrcodebank!),
              fit: BoxFit.fill,
            )),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Số cua :' + item.amount.toString(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
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
        ],
      ),
    );
  }
}
