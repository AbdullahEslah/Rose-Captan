import 'package:rose_captain/core/network_service/network_service.dart';
import 'package:rose_captain/modules/passengers/passengers_details/data/models/latest_passengers/passengers.dart';
import 'package:rose_captain/modules/passengers/passengers_details/domain/repositories/passengers_repository.dart';

class FetchPassengersUseCase {
  FetchPassengersUseCase(this.passengersRepository);
  final PassengersRepository passengersRepository;

  Future<Result<Passengers>> fetchAllPassengers() async {
    return await passengersRepository.fetchAllPassengers();
  }
}
