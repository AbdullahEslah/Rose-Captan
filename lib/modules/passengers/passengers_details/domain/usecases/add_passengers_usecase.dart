import 'package:flutter/cupertino.dart';
import 'package:rose_captain/modules/passengers/passengers_details/domain/repositories/passengers_repository.dart';

class AddPassengersUseCase {
  final PassengersRepository passengersRepository;
  AddPassengersUseCase(this.passengersRepository);

  Future<String> addPassengers(
      {required BuildContext context,
      required Map<String, dynamic> allFields,
      required int count,
      required String from,
      required String to}) async {
    return await passengersRepository.addPassengers(
        context: context,
        allFields: allFields,
        count: count,
        from: from,
        to: to);
  }
}
