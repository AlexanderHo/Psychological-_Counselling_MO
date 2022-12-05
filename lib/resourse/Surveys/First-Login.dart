import 'package:astrology/resourse/Home/home.dart';
import 'package:astrology/resourse/Surveys/SurveyType.dart';
import 'package:astrology/resourse/app_router.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Color(0xff17384e),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Trước khi tham gia tư vấn \n bạn cần làm bài khảo sát tâm\n lý. Bạn có muốn làm ngay không ?",
              style: TextStyle(color: Colors.amber, fontSize: 30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green[900],
                  ),
                  child: ElevatedButton(
                      onPressed: () {
                        AppRouter.push(HomeScreen());
                      },
                      child: const Text(
                        "Bỏ qua",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      )),
                ),
                Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green[900],
                  ),
                  child: ElevatedButton(
                      onPressed: () {
                        AppRouter.push(SurveyTypePage());
                      },
                      child: const Text(
                        "Làm test",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
