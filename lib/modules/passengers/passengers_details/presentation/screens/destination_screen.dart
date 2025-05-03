import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rose_captain/modules/passengers/passengers_details/presentation/screens/add_passengers_screen.dart';

import '../../../../../core/custom_widgets/background_body_widget/background_body_widget.dart';
import '../../../../../core/custom_widgets/custom_text_field/text_field_widget.dart';
import '../provider/passengers_details_provider.dart';

class DestinationScreen extends StatelessWidget {
  const DestinationScreen({super.key});
  static final GlobalKey<FormState> mainWidgetFormKey = GlobalKey<FormState>();

  Form buildMainView(PassengersDetailsProvider passengersDetailsProvider,
      BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Form(
      key: mainWidgetFormKey,
      child: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Text(
              "From Place",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          CustomTextFieldForm(
            controller: passengersDetailsProvider.fromControllerTextField,
            onChanged: (fromChanged) =>
                passengersDetailsProvider.updateFromTextField(fromChanged),
            keyboardType: TextInputType.text,
            placeholder: "From",
            emptyValueText: 'please type from field',
            // focus: nameFocus,
          ),
          SizedBox(height: screenHeight * 0.02),
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Text(
              "To",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          CustomTextFieldForm(
            controller: passengersDetailsProvider.toControllerTextField,
            onChanged: (idChanged) =>
                passengersDetailsProvider.updateToTextField(idChanged),
            placeholder: "destination place",
            emptyValueText: 'please type destination place',
            // focus: idNumberFocus,
          ),
          SizedBox(height: screenHeight * 0.02),
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Text(
              "Passengers Number",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          CustomTextFieldForm(
            keyboardType: TextInputType.number,
            controller:
                passengersDetailsProvider.passengersCountControllerTextField,
            onChanged: (count) =>
                passengersDetailsProvider.updatePassengersCountTextField(count),
            placeholder: "passengers count",
            emptyValueText: 'please type passengers count',
            // focus: idNumberFocus,
          ),
          SizedBox(height: screenHeight * 0.03),
          ElevatedButton(
            onPressed: () {
              if (mainWidgetFormKey.currentState?.validate() ?? false) {
                passengersDetailsProvider.setPassengerCount(int.parse(
                    passengersDetailsProvider
                            .passengersCountControllerTextField?.text ??
                        ""));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddPassengersScreen()),
                );
                //passengersDetailsProvider.resetAllDestinationFields();
              } else {
                print("Validation failed");
              }
            },
            child: Text("Next"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final appLocalizations = AppLocalizations.of(context)!;
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
            leading: IconButton(
                iconSize: 35,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: CircleBorder(
                    side: BorderSide(style: BorderStyle.none),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
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
          body: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: buildMainView(
                Provider.of<PassengersDetailsProvider>(context, listen: false),
                context),
          ),
        ),
      ),
    );
  }
}
