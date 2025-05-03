import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rose_captain/modules/passengers/passengers_details/domain/usecases/add_passengers_usecase.dart';
import 'package:rose_captain/modules/passengers/passengers_details/domain/usecases/fetch_passengers_use_case.dart';
import 'package:rose_captain/modules/passengers/passengers_details/presentation/enums/add_passengers_enum.dart';

import '../../../../../core/network_service/network_service.dart';
import '../../data/models/latest_passengers/passengers.dart';
import '../enums/fetch_passengers_enum.dart';

class PassengersDetailsProvider with ChangeNotifier {
  PassengersDetailsProvider(
      this.addPassengersUseCase, this.fetchPassengersUseCase);
  final AddPassengersUseCase addPassengersUseCase;
  final FetchPassengersUseCase fetchPassengersUseCase;

  /// first screen textFields
  final TextEditingController _fromControllerTextField =
      TextEditingController();
  TextEditingController? get fromControllerTextField =>
      _fromControllerTextField;

  final TextEditingController _toControllerTextField = TextEditingController();
  TextEditingController? get toControllerTextField => _toControllerTextField;

  final TextEditingController _passengersCountControllerTextField =
      TextEditingController();
  TextEditingController? get passengersCountControllerTextField =>
      _passengersCountControllerTextField;

  /// mainPageView configurations
  final PageController _pageController = PageController();
  PageController get pageController => _pageController;

  final List<GlobalKey<FormBuilderState>> _formKeys = [];
  List<GlobalKey<FormBuilderState>> get formKeys => _formKeys;

  int? _currentPageView;
  int get currentPageView => _currentPageView ?? 0;

  List<Widget>? _pageViewWidgetsLit;
  UnmodifiableListView<Widget>? get pageViewWidgetsLit {
    return UnmodifiableListView(_pageViewWidgetsLit ?? []);
  }

  List<AllPassengers>? _passengersList;
  UnmodifiableListView<AllPassengers>? get passengersList {
    return UnmodifiableListView(_passengersList ?? []);
  }

  int? _passengersCount;
  int? get passengersCount => _passengersCount;

  final Map<String, dynamic> _passengersBody = {};
  Map<String, dynamic> get passengersBody => _passengersBody;

  ///********************

  /// managing state
  /// responsible for loading, failure or success state
  AddPassengersEnum _addPassengersState = AddPassengersEnum.normal;
  AddPassengersEnum get addPassengersState => _addPassengersState;

  FetchPassengersEnum _fetchPassengersState = FetchPassengersEnum.normal;
  FetchPassengersEnum get fetchPassengersState => _fetchPassengersState;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void setAddPassengersState(AddPassengersEnum state) {
    _addPassengersState = state;
    notifyListeners();
  }

  // Reset to idle state
  void resetAddPassengersState() {
    _addPassengersState = AddPassengersEnum.normal;
    notifyListeners();
  }

  // Reset to idle state
  void resetFetchPassengersState() {
    _fetchPassengersState = FetchPassengersEnum.normal;
    notifyListeners();
  }

  void setFetchPassengersState(FetchPassengersEnum state) {
    _fetchPassengersState = state;
    notifyListeners();
  }

  void addToPassengersBody(Map<String, dynamic> newBody) {
    _passengersBody.addAll(newBody);
    notifyListeners();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _passengersCountControllerTextField.dispose();
    _fromControllerTextField.dispose();
    _toControllerTextField.dispose();
    super.dispose();
  }

  void addNewFormKey(GlobalKey<FormBuilderState> formKey) {
    _formKeys.add(formKey);
    notifyListeners();
  }

  void updateFromTextField(String fromField) {
    _fromControllerTextField.text = fromField;
    notifyListeners();
  }

  void updateToTextField(String toField) {
    _toControllerTextField.text = toField;
    notifyListeners();
  }

  void resetAllDestinationFields() {
    _fromControllerTextField.clear();
    _toControllerTextField.clear();
    _passengersCountControllerTextField.clear();
    notifyListeners();
  }

  void updatePassengersCountTextField(String passengersCountField) {
    _passengersCountControllerTextField.text = passengersCountField;
    notifyListeners();
  }

  void updateCurrentPageView(int pageViewIndex) {
    _currentPageView = pageViewIndex;
    notifyListeners();
  }

  void setPassengerCount(int passengerCount) {
    _passengersCount = passengerCount;
    notifyListeners();
  }

  void addWidget({required Widget addedWidget}) {
    _pageViewWidgetsLit?.add(addedWidget);
    notifyListeners();
  }

  void makeFirstWidget({Widget? currentPageViewWidget}) {
    _pageViewWidgetsLit = [currentPageViewWidget ?? SizedBox()];
    notifyListeners();
  }

  Future<String> addPassengers(BuildContext context,
      Map<String, dynamic> allFields, int count, String from, String to) async {
    String? result;
    setAddPassengersState(AddPassengersEnum.loading);
    try {
      result = await addPassengersUseCase.addPassengers(
          context: context,
          allFields: allFields,
          count: count,
          from: from,
          to: to);
      print(result);
      setAddPassengersState(AddPassengersEnum.success);
    } catch (e) {
      print(e);
      setAddPassengersState(AddPassengersEnum.error);
      setError(e.toString());
    }
    return result ?? "";
  }

  Future<List<AllPassengers>>? fetchAllPassengers() async {
    setFetchPassengersState(FetchPassengersEnum.loading);
    List<AllPassengers>? allPassengersArray;
    Result<Passengers> result =
        await fetchPassengersUseCase.fetchAllPassengers();
    switch (result) {
      case Ok<Passengers>():
        // التعامل مع البيانات المستلمة
        final data = result.value;
        allPassengersArray = result.value.data;
        _passengersList = allPassengersArray;
        setFetchPassengersState(FetchPassengersEnum.success);
        print(data.data);
        //notifyListeners();
        break;
      case Error<Passengers>():
        // التعامل مع الخطأ
        final error = result.error;
        print(error);
        allPassengersArray = null;
        setFetchPassengersState(FetchPassengersEnum.error);
        // notifyListeners();
        break;
    }
    return allPassengersArray ?? [];
  }
}
