import 'package:flutter/material.dart';
import 'package:rose_captain/core/network_service/network_service.dart';
import 'package:rose_captain/modules/passengers/passengers_details/data/datasources/passengers_remote_datasource.dart';
import 'package:rose_captain/modules/passengers/passengers_details/data/models/latest_passengers/passengers.dart';
import 'package:rose_captain/modules/passengers/passengers_details/domain/repositories/passengers_repository.dart';

class PassengersRepositoryImpl implements PassengersRepository {
  final PassengersRemoteDatasource passengersRemoteDatasource;
  PassengersRepositoryImpl(this.passengersRemoteDatasource);
  @override
  Future<String> addPassengers(
      {required BuildContext context,
      required Map<String, dynamic> allFields,
      required int count,
      required String from,
      required String to}) async {
    String response = await passengersRemoteDatasource.addPassengers(
        context: context,
        allFields: allFields,
        count: count,
        from: from,
        to: to);
    return response;
  }

  @override
  Future<Result<Passengers>> fetchAllPassengers() async {
    return await passengersRemoteDatasource.fetchAllPassengers();
  }
}
