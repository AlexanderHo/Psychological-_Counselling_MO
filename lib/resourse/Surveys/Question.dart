import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/model/Question_model.dart';
import 'package:astrology/model/Survey_model.dart';
import 'package:astrology/model/optionQuestion_model.dart';
import 'package:astrology/reponsitory/optionQuestion_.dart';
import 'package:astrology/reponsitory/question_.dart';
import 'package:astrology/resourse/Home/home.dart';
import 'package:astrology/resourse/Surveys/ResultSurvey.dart';
import 'package:astrology/resourse/app_router.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuestionPage extends StatefulWidget {
  int SurveyId;
  QuestionPage({required this.SurveyId});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

int question_pos = 0;
int score = 0;
bool btnPressed = false;
PageController? _controller;
String btnText = "Next Question";
String btnTextP = "Previous Question";
bool answered = false;
late Future<List<OptionModel>> ans;
final answer = <int>[];
bool isClicked = false;

class _QuestionPageState extends State<QuestionPage> {
  late Future<List<QuestionModel>> ques;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ques = fetchQuestion(widget.SurveyId);
    answer.clear();
    btnText = "Next Question";
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: TopBar.getAppBarHasBackIcon(size, context, 'Bài khảo sát', () {
          Navigator.pop(context);
        }),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    height: 650,
                    width: 420,
                    child: FutureBuilder<List<QuestionModel>>(
                      future: ques,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('something went wrong!!',
                                style: TextStyle(color: Colors.black54)),
                          );
                        } else if (snapshot.hasData) {
                          return QuesList(quesModels: snapshot.data!);
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
            ],
          ),
        ));
  }
}

class QuesList extends StatefulWidget {
  const QuesList({Key? key, this.quesModels, this.ansModels}) : super(key: key);
  final List<QuestionModel>? quesModels;
  final List<OptionModel>? ansModels;

  @override
  State<QuesList> createState() => _QuesListState();
}

class _QuesListState extends State<QuesList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ans = fetchOption(widget.quesModels![index].id);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      physics: NeverScrollableScrollPhysics(),
      controller: _controller!,
      onPageChanged: (page) {
        if (page == widget.quesModels!.length - 1) {
          //   setState(() {
          //     btnText = "See Results";
          //   });
          // }
          // setState(() {
          //   answered = false;
          // });
          setState(() {
            btnText = "See Results";
          });
        }
        physics:
        new NeverScrollableScrollPhysics();

        itemCount:
        widget.quesModels!.length;
      },
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Question ${index + 1}/" +
                      widget.quesModels!.length.toString(),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.0,
                  ),
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: double.infinity,
                height: 100.0,
                child: Text(
                  "${widget.quesModels![index].description}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                  ),
                ),
              ),
              // for (int i = 0; i < ansModels!.length; i++)
              //   Container(
              //     width: double.infinity,
              //     height: 50.0,
              //     margin: EdgeInsets.only(bottom: 20.0, left: 12.0, right: 12.0),
              //     child: RawMaterialButton(
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(8.0),
              //       ),
              //       // fillColor: btnPressed
              //       //     ? ansModels![index].optionText.
              //       //     .values.toList()[i]
              //       //         ? Colors.green
              //       //         : Colors.red
              //       //     : Color(0xFF117eeb),
              //       onPressed: () {},
              //       //  !answered
              //       //     ? () {
              //       //         if (ansModels![index].questionId ==
              //       //             quesModels![index].id) {
              //       //           score++;
              //       //           print("yes");
              //       //         } else {
              //       //           print("no");
              //       //         }
              //       // setState(() {
              //       //   btnPressed = true;
              //       //   answered = true;
              //       // }
              //       // );
              //       //   }
              //       // : null,
              //       child: Text(ansModels![index].optionText,
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 18.0,
              //           )),
              //     ),
              //   ),
              // SizedBox(
              //   height: 40.0,
              // ),
              Container(
                height: 400,
                width: 420,
                child: FutureBuilder<List<OptionModel>>(
                  future: fetchOption(widget.quesModels![index].id),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('something went wrong!!',
                            style: TextStyle(color: Colors.black54)),
                      );
                    } else if (snapshot.hasData) {
                      return OptionList(ansModels: snapshot.data!);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // RawMaterialButton(
                  //   // disabledElevation: _controller!.page?.toInt() == 0?0.0:,
                  //   onPressed: () {
                  //     if (_controller!.page?.toInt() == 0) {
                  //       // Navigator.push(
                  //       //     context,
                  //       //     MaterialPageRoute(
                  //       //         builder: (context) =>
                  //       //             ResultPage(answer: answer)));
                  //       // answer.clear();
                  //     } else {
                  //       _controller!.previousPage(
                  //           duration: Duration(milliseconds: 250),
                  //           curve: Curves.easeInExpo);

                  //       // AppRouter.push(QuestionPage(SurveyId: 1));
                  //       setState(() {
                  //         ans = fetchOption(widget.quesModels![index].id - 1);
                  //       });
                  //     }
                  //   },
                  //   shape: StadiumBorder(),
                  //   fillColor: Colors.blue,
                  //   padding: EdgeInsets.all(18.0),
                  //   elevation: 0.0,
                  //   child: Text(
                  //     btnTextP,
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  // ),
                  RawMaterialButton(
                    onPressed: () {
                      if (_controller!.page?.toInt() ==
                          widget.quesModels!.length - 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ResultPage(answer: answer)));
                        // dispose();
                        // answer.clear();
                      } else {
                        _controller!.nextPage(
                            duration: Duration(milliseconds: 250),
                            curve: Curves.easeInExpo);

                        // AppRouter.push(QuestionPage(SurveyId: 1));
                        setState(() {
                          ans = fetchOption(widget.quesModels![index].id + 1);
                        });
                      }
                    },
                    shape: StadiumBorder(),
                    fillColor: Colors.blue,
                    padding: EdgeInsets.all(18.0),
                    elevation: 0.0,
                    child: Text(
                      btnText,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
      itemCount: widget.quesModels!.length,
    );
  }
}

class OptionList extends StatefulWidget {
  const OptionList({Key? key, required this.ansModels}) : super(key: key);

  final List<OptionModel>? ansModels;

  @override
  State<OptionList> createState() => _OptionListState();
}

class _OptionListState extends State<OptionList> {
  List _selectedIndexs = [];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.ansModels!.length,
        itemBuilder: (BuildContext context, int index) {
          final _isSelected = _selectedIndexs.contains(index);
          return GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => BookingPage(
                //         slotId: SlotModels[index].id,
                //         timeStart: SlotModels[index].timeStart,
                //         timeEnd: SlotModels[index].timeEnd,
                //         price: SlotModels[index].price ?? 0,
                //         dateSlot: SlotModels[index].dateSlot,
                //         consultantName: SlotModels[index].consultantName,
                //         imageUrl: SlotModels[index].imageUrl,
                //         consultantId: SlotModels[index].consultantId,
                //         customerId: CurrentUser.getUserId()!),
                //     // PlanetdetailPage(
                //     //       id: planetModels[index].id,)
                //   ),
                // );
                // answer.add(widget.ansModels![index].id);

                setState(() {
                  if (_isSelected) {
                    _selectedIndexs.remove(index);
                    answer.remove(widget.ansModels![index].id);
                    print(answer);
                  } else {
                    _selectedIndexs.add(index);
                    answer.add(widget.ansModels![index].id);
                    print(answer);
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                    color: _isSelected ? Colors.red : Colors.green.shade50,
                    child: ansItem(
                      item: widget.ansModels![index],
                    )),
              ));
        });
  }
}

class ansItem extends StatelessWidget {
  OptionModel item;
  ansItem({required this.item});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(15.0),
          // color: isClicked ? Colors.white : Colors.green.shade50,
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, top: 5, right: 5, bottom: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                item.optionText,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
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
