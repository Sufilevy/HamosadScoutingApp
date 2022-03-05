import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/misc/database.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';
import 'widgets.dart';

mixin CancelReportButton {
  Widget getCancelReportButton(BuildContext context) => Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: FloatingActionButton(
            heroTag: "back",
            tooltip: langEntries['cancel_report'][currentLang['i']],
            child: Icon(
              Icons.close_rounded,
              color: Theme.of(context).canvasColor,
            ),
            backgroundColor: accentColor,
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => PopupDialog(
                  context,
                  title: langEntries['cancel_report'][currentLang['i']],
                  body:
                      "${langEntries['cancel_report_text_1'][currentLang['i']]}${currentLang == Lang.he ? '\n' : ''}${langEntries['cancel_report_text_1.5'][currentLang['i']]}\n${langEntries['cancel_report_text_2'][currentLang['i']]}",
                  buttons: [
                    PopupDialogButton(
                      text: langEntries['yes'][currentLang['i']],
                      onPressed: () => Navigator.of(context)
                          .popUntil((route) => route.isFirst),
                    ),
                    PopupDialogButton(
                      text: langEntries['no'][currentLang['i']],
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      );
}

mixin LastPageButton {
  Widget getLastPageButton(BuildContext context) => Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: FloatingActionButton(
            heroTag: "back",
            tooltip: langEntries['last_page'][currentLang['i']],
            child: Icon(
              Icons.arrow_back_rounded,
              color: Theme.of(context).canvasColor,
            ),
            backgroundColor: accentColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
}

mixin NextPageButton {
  Widget getNextPageButton(BuildContext context,
      {required StatefulWidget nextPage,
      bool? alert,
      AlertDialog? alertDialog}) {
    if (alert != null) assert(alertDialog != null);
    if (alertDialog != null) assert(alert != null);
    return Align(
      alignment: Alignment.bottomRight,
      child: FloatingActionButton(
        heroTag: "forward",
        tooltip: langEntries['next_page'][currentLang['i']],
        child: Icon(
          Icons.arrow_forward_rounded,
          color: Theme.of(context).canvasColor,
        ),
        backgroundColor: accentColor,
        onPressed: () {
          if (alert != null && alert) {
            showDialog(context: context, builder: (context) => alertDialog!);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => nextPage),
            );
          }
        },
      ),
    );
  }
}

mixin SubmitButton {
  Widget getSubmitButton(BuildContext context) => Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
            heroTag: "forward",
            tooltip: langEntries['submit_report'][currentLang['i']],
            child: Icon(
              Icons.check_rounded,
              color: Theme.of(context).canvasColor,
            ),
            backgroundColor: accentColor,
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => PopupDialog(
                  context,
                  title: langEntries['submit_report'][currentLang['i']],
                  body:
                      "${langEntries['submit_report_text_1'][currentLang['i']]}\n${langEntries['submit_report_text_2'][currentLang['i']]}",
                  buttons: [
                    PopupDialogButton(
                      text: langEntries['cancel'][currentLang['i']],
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    PopupDialogButton(
                      text: langEntries['submit'][currentLang['i']],
                      onPressed: () {
                        if (creatingNewReport) {
                          lastReport = (reportType == ReportType.game)
                              ? generateGameReportData(id: reportId)
                              : generatePitReportData(id: reportId);
                          reports.add(reportId);
                          lastReportType = reportType;
                        } else {
                          lastReport = (lastReportType == ReportType.game)
                              ? generateGameReportData(
                                  id: reportId,
                                  reporterName: lastReport["reporterName"],
                                  reporterTeam: lastReport["reporterTeam"],
                                )
                              : generatePitReportData(
                                  id: reportId,
                                  reporterName: lastReport["reporterName"],
                                  reporterTeam: lastReport["reporterTeam"],
                                );
                        }
                        sendReportToDatabase();

                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                    ),
                  ],
                ),
              );
            }),
      );
}
