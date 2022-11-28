import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/model/Consultant_model.dart';
import 'package:astrology/model/Specializations_model.dart';
import 'package:astrology/reponsitory/Consultant_.dart';
import 'package:astrology/reponsitory/Specia_.dart';
import 'package:astrology/resourse/SlotBooking/Slot_Booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AstroDetailPage extends StatefulWidget {
  int consulId;
  AstroDetailPage({required this.consulId});

  @override
  State<AstroDetailPage> createState() => _AstroDetailPageState();
}

class _AstroDetailPageState extends State<AstroDetailPage> {
  late Future<ConsultantModel> consult;
  // late Future<List<SpeciaModel>> spec;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    consult = fetchConsultantDetailData(widget.consulId);
    // spec = fetchSpec(widget.consulId);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: TopBar.getAppBarHasBackIcon(size, context, 'Consultant', () {
          Navigator.pop(context);
        }),
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
            // mainAxisAlignment: MainAxisAlignment.start,
            // children: [
            child: Column(
              children: [
                Container(
                  height: 600,
                  width: 420,
                  child: FutureBuilder<ConsultantModel>(
                    future: consult,
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
        ));
  }
}

class ShowDetail extends StatelessWidget {
  ConsultantModel item;
  ShowDetail({required this.item});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double? rating = item.rating ?? 0.0;
    int? experience = item.experience ?? 0;
    return Container(
      // width: size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              height: size.height * 0.25,
              width: size.width * 0.45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: NetworkImage(item.imageUrl!),
                    fit: BoxFit.fill,
                  )),
            ),
          ),
          Text(
            'Chuyên gia:' + item.fullName!,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Giới tính : ' + item.gender!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Địa chỉ : ' + item.address!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Email:' + item.email,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Số điện thoại:' + item.phone!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          // Container(
          //   height: 50,
          //   width: 420,
          //   child: FutureBuilder<List<SpeciaModel>>(
          //     future: fetchSpec(item.id),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasError) {
          //         return Center(
          //           child: Text('something went wrong!!',
          //               style: TextStyle(color: Colors.black54)),
          //         );
          //       } else if (snapshot.hasData) {
          //         return SpecList(SpeciaModels: snapshot.data!);
          //       } else {
          //         return Container(
          //             height: size.height,
          //             child: Center(
          //               child: CircularProgressIndicator(),
          //             ));
          //       }
          //     },
          //   ),
          // ),
          Text(
            'Chuyên môn :' + item.specialization!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Kinh nhiệm: Cấp ' + experience.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Text(
                  'Đánh giá :',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RatingBar.builder(
                  itemSize: 25,
                  initialRating: rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ],
            ),
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
                          MaterialPageRoute(
                            builder: (context) =>
                                SlotBookingPage(consultantId: item.id),
                          ));
                    },
                    child: Text(
                      'Đặc Lịch',
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

// class SpecList extends StatelessWidget {
//   const SpecList({Key? key, required this.SpeciaModels}) : super(key: key);

//   final List<SpeciaModel> SpeciaModels;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         scrollDirection: Axis.horizontal,
//         // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         //   crossAxisCount: 2,
//         //   // mainAxisSpacing:10.0,
//         //   // crossAxisSpacing:5.0,
//         //   childAspectRatio: 0.9,
//         // ),
//         itemCount: SpeciaModels.length,
//         itemBuilder: (BuildContext context, int index) {
//           return GestureDetector(
//               onTap: () {
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(
//                 //     builder: (context) => BookingPage(
//                 //         slotId: SlotModels[index].id,
//                 //         timeStart: SlotModels[index].timeStart,
//                 //         timeEnd: SlotModels[index].timeEnd,
//                 //         price: SlotModels[index].price ?? 0,
//                 //         dateSlot: SlotModels[index].dateSlot,
//                 //         consultantName: SlotModels[index].consultantName,
//                 //         imageUrl: SlotModels[index].imageUrl,
//                 //         consultantId: SlotModels[index].consultantId,
//                 //         customerId: CurrentUser.getUserId()!),
//                 //     // PlanetdetailPage(
//                 //     //       id: planetModels[index].id,)
//                 //   ),
//                 // );
//               },
//               child: SpeciaItem(
//                 item: SpeciaModels[index],
//               ));
//         });
//   }
// }

// class SpeciaItem extends StatelessWidget {
//   SpeciaModel item;
//   SpeciaItem({required this.item});

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Padding(
//       padding: const EdgeInsets.only(top: 10.0, right: 10.0),
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.black54),
//           borderRadius: BorderRadius.circular(15.0),
//           color: Colors.white,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.only(right: 5.0, left: 5.0),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 5.0,
//               ),
//               Text(
//                 item.specname,
//                 style: TextStyle(
//                   color: Colors.black54,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 20.0,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
