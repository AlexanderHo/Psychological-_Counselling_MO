import 'dart:convert';
import 'package:astrology/model/Feedback_model.dart';
import 'package:http/http.dart' as http;

List<FeedBackModel> parseFeedBack(List response) {
  return response
      .map<FeedBackModel>((json) => new FeedBackModel.fromJson(json))
      .toList();
}

//============================
Future<List<FeedBackModel>> fetchFeedBack(int id) async {
  var response = await http.Client().get(
      Uri.parse(
          'https://psycteam.azurewebsites.net/api/Consultants/getfeedbackbyid?id=' +
              id.toString()),
      headers: <String, String>{
        'accept': 'text/plain',
      });
  print(response.body);
  Map data = jsonDecode(response.body);
  print(data['data']);

  return parseFeedBack(data['data']);
}
