import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rose_captain/core/constants/apis.dart';
import 'package:rose_captain/core/utils/lang/app_language_provider.dart';
import 'package:rose_captain/modules/passengers/passengers_details/data/models/latest_passengers/passengers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/network_service/network_service.dart';

abstract class PassengersRemoteDatasource {
  Future<String> addPassengers(
      {required BuildContext context,
      required Map<String, dynamic> allFields,
      required int count,
      required String from,
      required String to});
  Future<Result<Passengers>> fetchAllPassengers();
}

class PassengersRemoteDatasourceImpl implements PassengersRemoteDatasource {
  @override
  Future<String> addPassengers(
      {required BuildContext context,
      required Map<String, dynamic> allFields,
      required int count,
      required String from,
      required String to}) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("userId") ?? "";
    Map<String, dynamic>? body;

    http.MultipartRequest request =
        http.MultipartRequest("POST", Apis.getEndpoint(Apis.addPassengers));

    if (context.mounted) {
      body = {
        "user_id": 19,
        "lang": Provider.of<AppLanguage>(context, listen: false),
        "count": count,
        "from": from,
        "to": to,
      };
      body.forEach((key, value) {
        request.fields[key] = value.toString();
      });
    }
    //  all textFields key and value from statelessWidget
    allFields.forEach((key, value) {
      request.fields[key] = value.toString();
    });
    final response = await request.send();
    return response.stream.bytesToString();
  }

  @override
  Future<Result<Passengers>> fetchAllPassengers() async {
    final prefs = await SharedPreferences.getInstance();
    final driverId = prefs.getString("userId") ?? "";
    final response = await NetworkService().request<Passengers>(
        url: "${Apis.getEndpoint("${Apis.allPassengers}/19")}",
        method: HttpMethod.get,
        fromJson: (data) => Passengers.fromJson(data));
    return response;
  }
// final http.Response response =
//     await http.get(Apis.getEndpoint("${Apis.allPassengers}/$driverId"));
}
