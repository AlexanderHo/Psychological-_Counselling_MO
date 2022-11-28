import 'package:astrology/model/ResultSurveys_model.dart';
import 'package:astrology/reponsitory/ResultSurveys_.dart';
import 'package:astrology/resourse/Home/home.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  List<int> answer;

  ResultPage({super.key, required this.answer});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late Future<ResultModel> result;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    result = getResult(widget.answer);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   elevation: 0.0,
      //   leading: IconButton(
      //     icon: Icon(
      //       Icons.arrow_back_ios,
      //       size: 15.0,
      //     ),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      //   iconTheme: IconThemeData(
      //     color: Colors.white,
      //   ),
      //   backgroundColor: Colors.transparent,
      //   bottomOpacity: 0.0,
      // ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          // height: 700,
          constraints:
              BoxConstraints(minHeight: size.height, minWidth: size.width),
          padding: EdgeInsets.fromLTRB(15.0, size.height * 0.1, 15.0, 0.0),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background/background1.png'),
                  fit: BoxFit.fill)),
          child: Column(
            children: [
              Container(
                height: 716,
                width: 400,
                child: FutureBuilder<ResultModel>(
                  future: result,
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
            ],
          ),
        ),
      ),
    );
  }
}

class ShowDetail extends StatelessWidget {
  ResultModel item;
  ShowDetail({required this.item});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: size.height * 0.8,
            width: size.width * 0.855,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(item.linkresult),
              fit: BoxFit.fill,
            )),
          ),
          SizedBox(
            height: 15.0,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => HomeScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'XÁC NHẬN',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
