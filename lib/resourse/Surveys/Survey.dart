import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/model/Survey_model.dart';
import 'package:astrology/reponsitory/Surveys_.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Question.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopBar.getAppBarHasBackIcon(size, context, 'Bài khảo sát', () {
        Navigator.pop(context);
      }),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/background/background1.png'),
          fit: BoxFit.fill,
        )),
        child: FutureBuilder<List<SurveysModel>>(
          future: fetchSurvey(http.Client()),
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
    );
  }
}

class SurveyList extends StatelessWidget {
  const SurveyList({Key? key, required this.surveyModels}) : super(key: key);

  final List<SurveysModel> surveyModels;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          // mainAxisSpacing:10.0,
          // crossAxisSpacing:5.0,
          childAspectRatio: 0.9,
        ),
        itemCount: surveyModels.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          QuestionPage(SurveyId: surveyModels[index].id)),
                );
              },
              child: SurveyItem(
                item: surveyModels[index],
              ));
        });
  }
}

class SurveyItem extends StatelessWidget {
  SurveysModel item;
  SurveyItem({required this.item});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
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
            item.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
