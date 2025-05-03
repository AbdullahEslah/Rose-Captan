import 'package:flutter/cupertino.dart';

import '../../../../../core/network_service/network_service.dart';
import '../../data/models/latest_passengers/passengers.dart';

abstract class PassengersRepository {
  Future<String> addPassengers(
      {required BuildContext context,
      required Map<String, dynamic> allFields,
      required int count,
      required String from,
      required String to});
  Future<Result<Passengers>> fetchAllPassengers();
}
