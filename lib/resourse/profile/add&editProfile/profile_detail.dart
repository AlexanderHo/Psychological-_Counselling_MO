import 'package:astrology/resourse/NatalChart/NatalChart_profile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../model/user.dart';
import 'edit_account.dart';

class ProfileDetailPage extends StatefulWidget {
  Profile item;
  ProfileDetailPage({required this.item});
  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromRGBO(27, 18, 53, 1),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(27, 18, 53, 1),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 15.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'Hồ sơ',
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.fromLTRB(15.0, 10, 15.0, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Center(
              //   child: Container(
              //     height: size.height * 0.16,
              //     width: size.width * 0.3,
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(15.0),
              //       image: DecorationImage(
              //         image: NetworkImage(widget.item.profilePhoto),
              //         fit: BoxFit.fill,
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: size.height * 0.03,
              // ),
              // name
              Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.white70),
                    color: Color.fromRGBO(250, 250, 250, 0.1),
                  ),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      //Icon
                      Container(
                        padding: EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            color: Color.fromRGBO(0, 0, 0, 0.3),
                            child: Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      //Column
                      Expanded(
                        child: Container(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 2),
                                height: 17,
                                child: Text(
                                  'Họ và Tên',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.white38,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.005,
                              ),
                              Container(
                                  child: SizedBox(
                                height: 24,
                                child: Text(
                                  widget.item.name,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                      //icon
                    ],
                  )),
              SizedBox(
                height: size.height * 0.01,
              ),
              // Container(
              //   padding: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       Container(
              //         height: size.height * 0.05,
              //         width: size.width * 0.43,
              //         decoration: BoxDecoration(
              //           // color: widget.item.gender!=
              //           //     ? Color.fromRGBO(116, 55, 245, 1)
              //           //     : Color.fromRGBO(38, 30, 63, 1),
              //           borderRadius: BorderRadius.circular(10.0),
              //           border: Border.all(color: Colors.white70),
              //         ),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: <Widget>[
              //             Icon(
              //               Icons.male,
              //               color: Colors.white,
              //             ),
              //             Text(
              //               'Nam',
              //               style: TextStyle(color: Colors.white),
              //             ),
              //           ],
              //         ),
              //       ),
              //       SizedBox(
              //         width: size.width * 0.05,
              //       ),
              //       Container(
              //         height: size.height * 0.05,
              //         width: size.width * 0.43,
              //         decoration: BoxDecoration(
              //           // color: widget.item.gender
              //           //     ? Color.fromRGBO(255, 74, 183, 1)
              //           //     : Color.fromRGBO(38, 30, 63, 1),
              //           borderRadius: BorderRadius.circular(10.0),
              //           border: Border.all(color: Colors.white70),
              //         ),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: <Widget>[
              //             Icon(
              //               Icons.female,
              //               color: Colors.white,
              //             ),
              //             Text(
              //               'Nữ',
              //               style: TextStyle(color: Colors.white),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.white70),
                    color: Color.fromRGBO(250, 250, 250, 0.1),
                  ),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      //Icon
                      Container(
                        padding: EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            color: Color.fromRGBO(0, 0, 0, 0.3),
                            child: Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      //Column
                      Expanded(
                        child: Container(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 2),
                                height: 17,
                                child: Text(
                                  'Giới tính',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.white38,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.005,
                              ),
                              Container(
                                  child: SizedBox(
                                height: 24,
                                child: Text(
                                  widget.item.gender,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                      //icon
                    ],
                  )),

              SizedBox(
                height: size.height * 0.01,
              ),
              // birthdate
              Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.white70),
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      //Icon
                      Container(
                        padding: EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            color: Color.fromRGBO(0, 0, 0, 0.3),
                            child: Icon(
                              Icons.cake,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      //Column
                      Expanded(
                        child: Container(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 2),
                                height: 17,
                                child: Text(
                                  'Ngày Sinh',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.white38,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.005,
                              ),
                              Container(
                                  child: SizedBox(
                                height: 24,
                                child: Text(
                                  DateFormat.yMd()
                                      .format(
                                          DateTime.parse(widget.item.birthDate))
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                      //icon
                    ],
                  )),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.white70),
                    color: Color.fromRGBO(250, 250, 250, 0.1),
                  ),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      //Icon
                      Container(
                        padding: EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            color: Color.fromRGBO(0, 0, 0, 0.3),
                            child: Icon(
                              Icons.place,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      //Column
                      Expanded(
                        child: Container(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 2),
                                height: 17,
                                child: Text(
                                  'Nơi Sinh',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.white38,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.005,
                              ),
                              Container(
                                  child: SizedBox(
                                height: 24,
                                child: Text(
                                  widget.item.birthPlace,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                      //icon
                    ],
                  )),
              SizedBox(
                height: size.height * 0.01,
              ),
              // Container(
              //     height: 80,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(15.0),
              //       border: Border.all(color:Colors.white70),
              //       color: Color.fromRGBO(250, 250, 250, 0.1),
              //     ),
              //     child: Row(
              //       // crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: <Widget>[
              //         //Icon
              //         Container(
              //           padding: EdgeInsets.all(8),
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(100),
              //             child: Container(
              //               color: Color.fromRGBO(0, 0, 0, 0.3),
              //               child: Icon(
              //                 Icons.place,
              //                 size: 40,
              //                 color: Colors.white,
              //               ),
              //             ),
              //           ),
              //         ),
              //         //Column
              //         Expanded(child: Container(
              //           child: Column(
              //             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             crossAxisAlignment: CrossAxisAlignment.stretch,
              //             children: <Widget>[
              //               Container(
              //                 padding: EdgeInsets.only(top: 2),
              //                 height: 17,
              //                 child: Text(
              //                   'Kinh Độ và Vĩ Độ',
              //                   textAlign: TextAlign.left,
              //                   style: TextStyle(
              //                     decoration: TextDecoration.none,
              //                     color: Colors.white38,
              //                     fontSize: 14.0,
              //                   ),
              //                 ),
              //               ),
              //               SizedBox(height: size.height * 0.005,),
              //               Container(
              //                   child: SizedBox(
              //                     height: 24,
              //                     child: Text(
              //                       'Kinh Độ: '+widget.item.longitude.toString(),
              //                       style: TextStyle(color: Colors.white, fontSize: 20),
              //                     ),
              //                   )
              //               ),
              //               Container(
              //                   child: SizedBox(
              //                     height: 24,
              //                     child: Text(
              //                       'Vĩ Độ: '+widget.item.latitude.toString(),
              //                       style: TextStyle(color: Colors.white, fontSize: 20),
              //                     ),
              //                   )
              //               ),
              //             ],
              //           ),
              //         ),),
              //         //icon

              //       ],
              //     )
              // ),
              // SizedBox(height: size.height * 0.01,),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NatalChartProfilePage(
                          name: widget.item.name,
                          id: widget.item.id,
                          chart: widget.item.birthChart),
                    ),
                  );
                },
                child: Text(
                  'Độ phù hợp ',
                  style: TextStyle(
                    fontSize: 20.0,
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

class AccountInformation {
  IconData icon;
  String title;
  String content;

  AccountInformation(
      {required this.icon, required this.title, required this.content});
}

class AccountItem1 extends StatefulWidget {
  AccountInformation item;

  AccountItem1({required this.item});

  @override
  State<AccountItem1> createState() => _AccountItem1State();
}

class _AccountItem1State extends State<AccountItem1> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.white70),
          color: Color.fromRGBO(250, 250, 250, 0.1),
        ),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //Icon
            Container(
              padding: EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                  child: Icon(
                    widget.item.icon,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            //Column
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 2),
                      height: 17,
                      child: Text(
                        widget.item.title,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white38,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    Container(
                        child: SizedBox(
                      height: 24,
                      child: Text(
                        widget.item.content,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            //icon
          ],
        ));
  }
}
