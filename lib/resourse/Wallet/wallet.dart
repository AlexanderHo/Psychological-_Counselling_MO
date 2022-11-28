import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/model/Transaction_model.dart';
import 'package:astrology/model/wallet_model.dart';
import 'package:astrology/reponsitory/Wallet_.dart';
import 'package:astrology/reponsitory/transaction_.dart';
import 'package:astrology/resourse/Wallet/Deposit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  late Future<WalletModel> wallet;
  late Future<List<TransactionModel>> transaction;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wallet = fetchWallet();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopBar.getAppBarHasBackIcon(size, context, 'Ví của bạn', () {
        Navigator.pop(context);
      }),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: FutureBuilder<WalletModel>(
                future: wallet,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('something went wrong!!',
                          style: TextStyle(color: Colors.black54)),
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
            Text(
              'Lịch sử giao dịch',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                // height: 600,
                // width: 500,
                child: FutureBuilder<List<TransactionModel>>(
                  future: fetchTransaction(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('something went wrong!!',
                            style: TextStyle(color: Colors.black54)),
                      );
                    } else if (snapshot.hasData) {
                      return TransacList(transacModels: snapshot.data!);
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
          ],
        ),
      ),
    );
  }
}

class ShowDetail extends StatelessWidget {
  WalletModel item;
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
            height: 200,
            width: 450,
            decoration: BoxDecoration(
                color: Colors.purple.shade100,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(38),
                  bottomRight: Radius.circular(38),
                )),
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            'Số Gem :' + item.crab.toString(),
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'roboto'),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white70,
                          ),
                          child: Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return DepositPage();
                                      },
                                    ));
                                  },
                                  icon: Image.asset(
                                    "assets/icon/deposit.png",
                                    color: Colors.black87,
                                    width: size.width * 0.1,
                                  ),
                                  iconSize: size.width * 0.15),
                              Text(
                                'Nạp',
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.black54,
                                  fontSize: 18.0,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TransacList extends StatelessWidget {
  const TransacList({Key? key, required this.transacModels}) : super(key: key);
  final List<TransactionModel> transacModels;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        // padding: const EdgeInsets.all(8),
        itemCount: transacModels.length,
        itemBuilder: (BuildContext context, int index) {
          if (index != 0) {
            return TransacItem(
              item: transacModels[index],
              // name: profileList[index].name,
              // imageLink: profileList[index].,
            );
          } else {
            return SizedBox();
          }
        },
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox());
    // GridView.builder(
    //     scrollDirection: Axis.vertical,
    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2,
    //       // mainAxisSpacing:10.0,
    //       // crossAxisSpacing:5.0,
    //       childAspectRatio: 0.9,
    //     ),
    //     itemCount: transacModels.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       return GestureDetector(
    //           onTap: () {},
    //           child: TransacItem(
    //             item: transacModels[index],
    //           ));
    //     });
  }
}

class TransacItem extends StatelessWidget {
  TransactionModel item;
  TransacItem({required this.item});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String des = item.description ?? '';
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        // height: 70,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.blueGrey[200],
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  'Ngày: ' +
                      DateFormat.yMd()
                          .format(DateTime.parse(item.dateCreate))
                          .toString(),
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  des,
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
