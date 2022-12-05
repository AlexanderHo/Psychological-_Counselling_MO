import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/model/SurveyType_model.dart';
import 'package:astrology/reponsitory/SurveyType_.dart';
import 'package:astrology/resourse/Surveys/First-Login.dart';
import 'package:astrology/resourse/Surveys/Result.dart';
import 'package:astrology/resourse/Surveys/ResultSurvey.dart';
import 'package:astrology/resourse/Surveys/Survey.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SurveyTypePage extends StatefulWidget {
  const SurveyTypePage({super.key});

  @override
  State<SurveyTypePage> createState() => _SurveyTypePageState();
}

class _SurveyTypePageState extends State<SurveyTypePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopBar.getAppBarHasBackIcon(size, context, 'Loại khảo sát', () {
        Navigator.pop(context);
      }),
      body: Container(
        constraints:
            BoxConstraints(minHeight: size.height, minWidth: size.width),
        color: Color(0xff031d2e),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color(0xff17384e),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                        color: Colors.white60,
                                      )))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultEndPage()));
                      },
                      child: Text(
                        'Kết quả khảo sát của bạn',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ))),
            ),
            Container(
              height: 500,
              width: 500,
              child: FutureBuilder<List<SurveysTypeModel>>(
                future: fetchSurveyType(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Something went wrong!!'),
                    );
                  } else if (snapshot.hasData) {
                    return SurveyList(surveyModels: snapshot.data!);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SurveyList extends StatelessWidget {
  const SurveyList({Key? key, required this.surveyModels}) : super(key: key);

  final List<SurveysTypeModel> surveyModels;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //   crossAxisCount: 1,
        //   // mainAxisSpacing:10.0,
        //   // crossAxisSpacing:5.0,
        //   childAspectRatio: 0.9,
        // ),
        itemCount: surveyModels.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SurveyPage(id: surveyModels[index].id)),
                );
              },
              child: SurveyItem(
                item: surveyModels[index],
              ));
        });
  }
}

class SurveyItem extends StatelessWidget {
  SurveysTypeModel item;
  SurveyItem({required this.item});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white60),
          borderRadius: BorderRadius.circular(12.0),
          color: Color(0xff17384e),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Container(
              //   height: size.height * 0.2,
              //   decoration: BoxDecoration(
              //       image: DecorationImage(
              //     image: NetworkImage(item.description),
              //   )),
              // ),
              Text(
                'Tên loại khảo sát :' + item.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
