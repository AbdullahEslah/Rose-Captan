import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rose_captain/modules/passengers/passengers_details/presentation/screens/all_passengers_screen.dart';

import '../../../../core/custom_widgets/background_body_widget/background_body_widget.dart';
import '../../../passengers/passengers_details/presentation/screens/destination_screen.dart';
import '../../../passengers/passengers_details/presentation/screens/add_passengers_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final appLocalizations = AppLocalizations.of(context)!;
    return BackgroundBodyWidget(
      imageName: "backgroundHome.jpg",
      imageScale: BoxFit.fill,
      opacity: 0.4,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "Passengers Dashboard",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          toolbarHeight: screenHeight * 0.09,
          backgroundColor: Colors.blue[900],
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
        body: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      foregroundColor: Colors.white),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DestinationScreen()),
                  ),
                  icon: PhysicalModel(
                    color: Colors.transparent,
                    elevation: 8,
                    shadowColor: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    child: Row(
                      spacing: 8,
                      children: [
                        Text(
                          "Add Passengers",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Icon(
                          Icons.add,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                  // child:
                ),
                IconButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      foregroundColor: Colors.white),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AllPassengersScreen()),
                  ),
                  icon: PhysicalModel(
                    color: Colors.transparent,
                    elevation: 8,
                    shadowColor: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    child: Row(
                      spacing: 8,
                      children: [
                        Text(
                          "All Passengers",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Icon(
                          Icons.list_alt,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
