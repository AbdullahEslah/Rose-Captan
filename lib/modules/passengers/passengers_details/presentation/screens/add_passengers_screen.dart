import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rose_captain/modules/passengers/passengers_details/presentation/enums/add_passengers_enum.dart';

import '../../../../../core/custom_widgets/background_body_widget/background_body_widget.dart';
import '../../../../home/presentation/screens/home_screen.dart';
import '../provider/passengers_details_provider.dart';

class AddPassengersScreen extends StatelessWidget {
  const AddPassengersScreen({super.key});
  PageView buildPageView(PassengersDetailsProvider passengersDetailsProvider,
      BuildContext context) {
    for (var i = 0; i < (passengersDetailsProvider.passengersCount ?? 0); i++) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        passengersDetailsProvider.addNewFormKey(GlobalKey<FormBuilderState>());
      });
    }
    return PageView.builder(
      itemCount: passengersDetailsProvider.formKeys.length,
      onPageChanged: (currentPageViewIndex) =>
          passengersDetailsProvider.updateCurrentPageView(currentPageViewIndex),
      controller: passengersDetailsProvider.pageController,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      pageSnapping: true,
      itemBuilder: (BuildContext context, int index) {
        return passengersDetailsWidget(
            passengersDetailsProvider, index, context);
      },
    );
  }

  SingleChildScrollView passengersDetailsWidget(
      PassengersDetailsProvider passengersDetailsProvider,
      int index,
      BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: FormBuilder(
          key: passengersDetailsProvider.formKeys[index],
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'passenger_list[$index][name]',
                decoration: InputDecoration(labelText: "name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter passenger name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              FormBuilderTextField(
                keyboardType: TextInputType.number,
                name: 'passenger_list[$index][id_number]',
                decoration: InputDecoration(labelText: "ID Number"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter passenger ID number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              FormBuilderTextField(
                name: 'passenger_list[$index][Gender]',
                decoration: InputDecoration(labelText: "Gender"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter passenger gender';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              FormBuilderTextField(
                keyboardType: TextInputType.phone,
                name: 'passenger_list[$index][Phone_number]',
                decoration: InputDecoration(labelText: "Phone Number"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter passenger phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (passengersDetailsProvider.formKeys[index].currentState
                          ?.saveAndValidate() ??
                      false) {
                    print(
                        "data is ${passengersDetailsProvider.formKeys[index].currentState!.value}");
                    passengersDetailsProvider.addToPassengersBody(
                        passengersDetailsProvider
                            .formKeys[index].currentState!.value);

                    if (index ==
                        (passengersDetailsProvider.passengersCount ?? 0) - 1) {
                      await passengersDetailsProvider.addPassengers(
                          context,
                          passengersDetailsProvider.passengersBody,
                          passengersDetailsProvider.passengersCount ?? 0,
                          passengersDetailsProvider
                                  .fromControllerTextField?.text ??
                              "",
                          passengersDetailsProvider
                                  .toControllerTextField?.text ??
                              "");
                    } else {
                      // الانتقال إلى الصفحة التالية
                      passengersDetailsProvider.pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    }
                  }
                },
                child: Text(index ==
                        (passengersDetailsProvider.passengersCount ?? 0) - 1
                    ? 'Submit'
                    : 'Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final appLocalizations = AppLocalizations.of(context)!;
    final provider =
        Provider.of<PassengersDetailsProvider>(context, listen: false);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BackgroundBodyWidget(
        imageName: "passengers.jpg",
        imageScale: BoxFit.fill,
        child: Scaffold(
          backgroundColor: Colors.white.withAlpha(-88),
          appBar: AppBar(
            toolbarHeight: screenHeight * 0.09,
            backgroundColor: Colors.blue[900],
            title: Text(
              "Destination Details",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            leading: SizedBox(
              child: IconButton(
                  iconSize: 35,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: CircleBorder(
                      side: BorderSide(style: BorderStyle.none),
                    ),
                  ),
                  onPressed: () {
                    /*
                      if current pageViewIndex == 0 pop
                      => else go previous pageView else
                     */
                    if (provider.currentPageView == 0) {
                      Navigator.pop(context);
                    } else {
                      provider.pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    }
                  },
                  icon: Icon(
                    color: Colors.white,
                    appLocalizations.localeName == "en"
                        ? CupertinoIcons.arrow_left_circle_fill
                        : CupertinoIcons.arrow_right_circle_fill,
                    // size: 30,
                  )
                  //child: ,
                  ),
            ),
          ),
          body: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Consumer<PassengersDetailsProvider>(builder:
                (BuildContext context,
                    PassengersDetailsProvider passengersProvider,
                    Widget? child) {
              switch (passengersProvider.addPassengersState) {
                case AddPassengersEnum.normal:
                  return buildPageView(passengersProvider, context);

                case AddPassengersEnum.loading:
                  return Center(
                    child: CupertinoActivityIndicator(
                      color: Colors.black,
                      radius: 25,
                    ),
                  );

                case AddPassengersEnum.error:
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                        provider.errorMessage ?? "",
                        style: TextStyle(color: Colors.red),
                      )),
                    );
                    passengersProvider.resetAddPassengersState();
                  });
                  break;

                case AddPassengersEnum.success:
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                        'Your Passengers Submitted Successfully!',
                        style: TextStyle(color: Colors.green),
                      )),
                    );
                    passengersProvider.resetAddPassengersState();

                    //  pop to home screen
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (Route<dynamic> route) =>
                          false, // This removes all previous routes
                    );
                  });
              }
              return buildPageView(passengersProvider, context);
            }),
          ),
        ),
      ),
    );
  }
}
