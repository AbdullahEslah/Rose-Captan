import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:rose_captain/modules/passengers/passengers_details/data/models/latest_passengers/passengers.dart';
import 'package:rose_captain/modules/passengers/passengers_details/presentation/provider/passengers_details_provider.dart';

import '../enums/fetch_passengers_enum.dart';

class AllPassengersScreen extends StatelessWidget {
  const AllPassengersScreen({super.key});

  //  for printing all trips
  Future<void> _generatePdf(BuildContext context,
      PassengersDetailsProvider passengersProvider) async {
    final pdf = pw.Document();

    final fontRegular =
        pw.Font.ttf(await rootBundle.load("assets/fonts/Amiri-Regular.ttf"));
    final fontBold =
        pw.Font.ttf(await rootBundle.load("assets/fonts/Amiri-Bold.ttf"));

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text(
                textDirection: pw.TextDirection.rtl,
                "Passengers Info",
                style: pw.TextStyle(
                  fontSize: 25,
                  // fontWeight: pw.FontWeight.bold,
                  font: fontBold, // ✅ استخدم الخط الداعم للعربية
                ),
              ), // ✅ استخدم الخط الداعم للعربية)),
              pw.SizedBox(height: 10),
              pw.TableHelper.fromTextArray(
                border: pw.TableBorder.all(width: 1),
                headerDecoration: pw.BoxDecoration(color: PdfColors.blue900),
                headerStyle: pw.TextStyle(
                    fontSize: 12, font: fontBold, color: PdfColors.white),
                cellStyle: pw.TextStyle(
                    fontSize: 10, font: fontRegular, color: PdfColors.black),
                columnWidths: {
                  0: pw.FlexColumnWidth(3),
                  1: pw.FlexColumnWidth(1),
                  2: pw.FlexColumnWidth(2),
                  3: pw.FlexColumnWidth(2),
                  4: pw.FlexColumnWidth(1),
                  5: pw.FlexColumnWidth(1),
                },
                headers: [
                  "Name",
                  "Gender",
                  "ID Number",
                  "Phone Number",
                  "From",
                  "To"
                ],
                data:
                    passengersProvider.passengersList!.expand((passengerItem) {
                  return passengerItem.list!.map((passenger) {
                    return [
                      pw.Text(
                        passenger.name ?? "",
                        textDirection: pw.TextDirection.rtl,
                        style: pw.TextStyle(font: fontRegular),
                      ),
                      pw.Text(
                        passenger.gender ?? "",
                        textDirection: pw.TextDirection.rtl,
                        style: pw.TextStyle(font: fontRegular),
                      ),
                      pw.Text(
                        passenger.idNumber ?? "",
                        textDirection: pw.TextDirection.ltr,
                        style: pw.TextStyle(font: fontRegular),
                      ),
                      pw.Text(
                        passenger.phoneNumber ?? "",
                        textDirection: pw.TextDirection.ltr,
                        style: pw.TextStyle(font: fontRegular),
                      ),
                      pw.Text(
                        passengerItem.from ?? "",
                        textDirection: pw.TextDirection.rtl,
                        style: pw.TextStyle(font: fontRegular),
                      ),
                      pw.Text(
                        passengerItem.to ?? "",
                        textDirection: pw.TextDirection.rtl,
                        style: pw.TextStyle(font: fontRegular),
                      ),
                    ];
                  }).toList();
                }).toList(),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  //  for printing each trip
  Future<void> _generateEachPdf(
      BuildContext context, AllPassengers passengerItem) async {
    final pdf = pw.Document();

    final fontRegular =
        pw.Font.ttf(await rootBundle.load("assets/fonts/Amiri-Regular.ttf"));
    final fontBold =
        pw.Font.ttf(await rootBundle.load("assets/fonts/Amiri-Bold.ttf"));

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text(
                "Passengers Info - Trip ID ${passengerItem.id}",
                textDirection: pw.TextDirection.rtl,
                style: pw.TextStyle(
                  fontSize: 20,
                  font: fontBold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.TableHelper.fromTextArray(
                border: pw.TableBorder.all(width: 1),
                headerDecoration: pw.BoxDecoration(color: PdfColors.blue900),
                headerStyle: pw.TextStyle(
                    fontSize: 12, font: fontBold, color: PdfColors.white),
                cellStyle: pw.TextStyle(
                    fontSize: 10, font: fontRegular, color: PdfColors.black),
                columnWidths: {
                  0: pw.FlexColumnWidth(3),
                  1: pw.FlexColumnWidth(1),
                  2: pw.FlexColumnWidth(2),
                  3: pw.FlexColumnWidth(2),
                  4: pw.FlexColumnWidth(1),
                  5: pw.FlexColumnWidth(1),
                },
                headers: [
                  "Name",
                  "Gender",
                  "ID Number",
                  "Phone Number",
                  "From",
                  "To"
                ],
                data: passengerItem.list!.map((passenger) {
                  return [
                    pw.Text(
                      passenger.name ?? "",
                      textDirection: pw.TextDirection.rtl,
                      style: pw.TextStyle(font: fontRegular),
                    ),
                    pw.Text(
                      passenger.gender ?? "",
                      textDirection: pw.TextDirection.rtl,
                      style: pw.TextStyle(font: fontRegular),
                    ),
                    pw.Text(
                      passenger.idNumber ?? "",
                      textDirection: pw.TextDirection.ltr,
                      style: pw.TextStyle(font: fontRegular),
                    ),
                    pw.Text(
                      passenger.phoneNumber ?? "",
                      textDirection: pw.TextDirection.ltr,
                      style: pw.TextStyle(font: fontRegular),
                    ),
                    pw.Text(
                      passengerItem.from ?? "",
                      textDirection: pw.TextDirection.rtl,
                      style: pw.TextStyle(font: fontRegular),
                    ),
                    pw.Text(
                      passengerItem.to ?? "",
                      textDirection: pw.TextDirection.rtl,
                      style: pw.TextStyle(font: fontRegular),
                    ),
                  ];
                }).toList(),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  Future<void> fetchAllPassengers(BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<PassengersDetailsProvider>().fetchAllPassengers();
    });
  }

  Expanded buildListView(
      BuildContext context, PassengersDetailsProvider passengersProvider) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Expanded(
      child: ListView.builder(
        itemCount: passengersProvider.passengersList?.length ?? 0,
        itemBuilder: (context, index) {
          var passengerItem = passengersProvider.passengersList?[index];

          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Passengers ID ${passengerItem?.id ?? 0}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    border: TableBorder.all(color: Colors.black54, width: 1),
                    headingRowColor: WidgetStateProperty.all(Colors.blue[900]),
                    columnSpacing: 16,
                    columns: [
                      DataColumn(
                          label: Text('Name',
                              style: TextStyle(color: Colors.white))),
                      DataColumn(
                          label: Text('Gender',
                              style: TextStyle(color: Colors.white))),
                      DataColumn(
                          label: Text('ID Number',
                              style: TextStyle(color: Colors.white))),
                      DataColumn(
                          label: Text('Phone Number',
                              style: TextStyle(color: Colors.white))),
                      DataColumn(
                          label: Text('From',
                              style: TextStyle(color: Colors.white))),
                      DataColumn(
                          label: Text('To',
                              style: TextStyle(color: Colors.white))),
                    ],
                    rows: passengerItem?.list?.map<DataRow>((passenger) {
                          return DataRow(cells: [
                            DataCell(Text(passenger.name ?? "",
                                style: TextStyle(fontSize: 10))),
                            DataCell(Text(passenger.gender ?? "",
                                style: TextStyle(fontSize: 10))),
                            DataCell(Text(passenger.idNumber ?? "",
                                style: TextStyle(fontSize: 10))),
                            DataCell(Text(passenger.phoneNumber ?? "",
                                style: TextStyle(fontSize: 10))),
                            DataCell(Text(passengerItem.from ?? "",
                                style: TextStyle(fontSize: 10))),
                            DataCell(Text(passengerItem.to ?? "",
                                style: TextStyle(fontSize: 10))),
                          ]);
                        }).toList() ??
                        [],
                  ),
                ),
                IconButton(
                    iconSize: 20,
                    style: IconButton.styleFrom(
                        fixedSize: Size(200, 16),
                        backgroundColor: Colors.blue[900]),
                    onPressed: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) async {
                        await _generateEachPdf(context, passengerItem!);
                      });
                    },
                    icon: Row(spacing: 16, children: [
                      Icon(
                        Icons.print,
                        color: Colors.white,
                      ),
                      Text(
                          textAlign: TextAlign.start,
                          "Print This Trip",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      Icon(
                        appLocalizations.localeName == "en"
                            ? Icons.arrow_forward
                            : Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ])),
                Divider()
              ]);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.09,
        backgroundColor: Colors.blue[900],
        title: Text(
          "All Passengers",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.print, color: Colors.white),
            onPressed: () async {
              final passengersProvider = Provider.of<PassengersDetailsProvider>(
                  context,
                  listen: false);
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                await _generatePdf(context, passengersProvider);
              });
            },
          ),
        ],
        leading: IconButton(
          iconSize: 35,
          icon: Icon(
            color: Colors.white,
            appLocalizations.localeName == "en"
                ? Icons.arrow_back
                : Icons.arrow_forward,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body:
          //SafeArea(
          FutureBuilder(
              future: fetchAllPassengers(context),
              builder: (context, snapshot) {
                //  because we use here provider a lot
                return Consumer<PassengersDetailsProvider>(
                  builder: (context, passengersProvider, child) {
                    switch (passengersProvider.fetchPassengersState) {
                      case FetchPassengersEnum.normal:
                        return Column(
                          children: [
                            Text(
                              "Passengers Info",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Divider(
                              endIndent: 150,
                            ),
                            buildListView(context, passengersProvider)
                          ],
                        );

                      case FetchPassengersEnum.loading:
                        return Center(
                          child: CupertinoActivityIndicator(
                            color: Colors.black,
                            radius: 20,
                          ),
                        );

                      case FetchPassengersEnum.error:
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                              passengersProvider.errorMessage ?? "",
                              style: TextStyle(color: Colors.red),
                            )),
                          );
                          passengersProvider.resetFetchPassengersState();
                        });
                        break;

                      case FetchPassengersEnum.success:
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          Column(
                            children: [
                              Text(
                                "Passengers Info",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Divider(
                                endIndent: 150,
                              ),
                              buildListView(context, passengersProvider)
                            ],
                          );
                          passengersProvider.resetFetchPassengersState();
                          //  pop to home screen
                          //Navigator.pop(context);
                        });
                    }
                    return Column(
                      children: [
                        Text(
                          "Passengers Info",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Divider(
                          endIndent: 150,
                        ),
                        buildListView(context, passengersProvider)
                      ],
                    );

                    // return SafeArea(
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 16, vertical: 16),
                    //     child: Column(
                    //       spacing: 8,
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         FutureBuilder(
                    //             future: fetchAllPassengers(context),
                    //             builder: (context, snapshot) {
                    //               return Expanded(
                    //                 child: ListView.builder(
                    //                   itemCount: passengersProvider
                    //                           .passengersList?.length ??
                    //                       0,
                    //                   itemBuilder: (context, index) {
                    //                     var passengerItem = passengersProvider
                    //                         .passengersList?[index];
                    //
                    //                     return Column(
                    //                         crossAxisAlignment:
                    //                             CrossAxisAlignment.start,
                    //                         children: [
                    //                           Text(
                    //                             "Passengers ID ${passengerItem?.id ?? 0}",
                    //                             style: TextStyle(
                    //                                 fontWeight: FontWeight.bold,
                    //                                 fontSize: 16),
                    //                           ),
                    //                           SingleChildScrollView(
                    //                             scrollDirection: Axis.horizontal,
                    //                             child: DataTable(
                    //                               border: TableBorder.all(
                    //                                   color: Colors.black54,
                    //                                   width: 1),
                    //                               headingRowColor:
                    //                                   WidgetStateProperty.all(
                    //                                       Colors.blue[900]),
                    //                               columnSpacing: 16,
                    //                               columns: [
                    //                                 DataColumn(
                    //                                     label: Text('Name',
                    //                                         style: TextStyle(
                    //                                             color:
                    //                                                 Colors.white))),
                    //                                 DataColumn(
                    //                                     label: Text('Gender',
                    //                                         style: TextStyle(
                    //                                             color:
                    //                                                 Colors.white))),
                    //                                 DataColumn(
                    //                                     label: Text('ID Number',
                    //                                         style: TextStyle(
                    //                                             color:
                    //                                                 Colors.white))),
                    //                                 DataColumn(
                    //                                     label: Text('Phone Number',
                    //                                         style: TextStyle(
                    //                                             color:
                    //                                                 Colors.white))),
                    //                                 DataColumn(
                    //                                     label: Text('From',
                    //                                         style: TextStyle(
                    //                                             color:
                    //                                                 Colors.white))),
                    //                                 DataColumn(
                    //                                     label: Text('To',
                    //                                         style: TextStyle(
                    //                                             color:
                    //                                                 Colors.white))),
                    //                               ],
                    //                               rows: passengerItem?.list
                    //                                       ?.map<DataRow>(
                    //                                           (passenger) {
                    //                                     return DataRow(cells: [
                    //                                       DataCell(Text(
                    //                                           passenger.name ?? "",
                    //                                           style: TextStyle(
                    //                                               fontSize: 10))),
                    //                                       DataCell(Text(
                    //                                           passenger.gender ??
                    //                                               "",
                    //                                           style: TextStyle(
                    //                                               fontSize: 10))),
                    //                                       DataCell(Text(
                    //                                           passenger.idNumber ??
                    //                                               "",
                    //                                           style: TextStyle(
                    //                                               fontSize: 10))),
                    //                                       DataCell(Text(
                    //                                           passenger
                    //                                                   .phoneNumber ??
                    //                                               "",
                    //                                           style: TextStyle(
                    //                                               fontSize: 10))),
                    //                                       DataCell(Text(
                    //                                           passengerItem.from ??
                    //                                               "",
                    //                                           style: TextStyle(
                    //                                               fontSize: 10))),
                    //                                       DataCell(Text(
                    //                                           passengerItem.to ??
                    //                                               "",
                    //                                           style: TextStyle(
                    //                                               fontSize: 10))),
                    //                                     ]);
                    //                                   }).toList() ??
                    //                                   [],
                    //                             ),
                    //                           ),
                    //                           IconButton(
                    //                               iconSize: 20,
                    //                               style: IconButton.styleFrom(
                    //                                   fixedSize: Size(200, 16),
                    //                                   backgroundColor:
                    //                                       Colors.blue[900]),
                    //                               onPressed: () {
                    //                                 WidgetsBinding.instance
                    //                                     .addPostFrameCallback(
                    //                                         (_) async {
                    //                                   await _generateEachPdf(
                    //                                       context, passengerItem!);
                    //                                 });
                    //                               },
                    //                               icon: Row(spacing: 16, children: [
                    //                                 Icon(
                    //                                   Icons.print,
                    //                                   color: Colors.white,
                    //                                 ),
                    //                                 Text(
                    //                                     textAlign: TextAlign.start,
                    //                                     "Print This Trip",
                    //                                     style: TextStyle(
                    //                                         color: Colors.white,
                    //                                         fontSize: 16)),
                    //                                 Icon(
                    //                                   appLocalizations.localeName ==
                    //                                           "en"
                    //                                       ? Icons.arrow_forward
                    //                                       : Icons.arrow_back,
                    //                                   color: Colors.white,
                    //                                 ),
                    //                               ])),
                    //                           Divider()
                    //                         ]);
                    //                   },
                    //                 ),
                    //               );
                    //             }),
                    //       ],
                    //     ),
                    //   ),
                    // );
                  },
                );
              }),
    );

    // );
  }
}
