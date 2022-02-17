import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';
import 'widgets.dart';

mixin CancelReportButton {
  Widget getCancelReportButton(BuildContext context) => Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: FloatingActionButton(
            heroTag: "back",
            tooltip: "Cancel report",
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
                  title: "Cancel Report",
                  body:
                      "Are you sure you want to cancel the report?\nThis will delete all of the information entered.",
                  buttons: [
                    PopupDialogButton(
                      text: "YES",
                      onPressed: () => Navigator.of(context)
                          .popUntil((route) => route.isFirst),
                    ),
                    PopupDialogButton(
                      text: "NO",
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
            tooltip: "Last page",
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
        tooltip: "Next page",
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
            tooltip: "Submit report",
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
                  title: "Submit Report",
                  body:
                      "Are you sure you're finished with your report?\nClick 'SUBMIT' to confirm and send the report, or click 'CANCEL' to keep editing.",
                  buttons: [
                    PopupDialogButton(
                      text: "CANCEL",
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    PopupDialogButton(
                      text: "SUBMIT",
                      onPressed: () => Navigator.of(context)
                          .popUntil((route) => route.isFirst),
                    ),
                  ],
                ),
              );
            }),
      );
}
