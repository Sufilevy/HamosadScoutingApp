import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/misc/data_container.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';
import 'package:hamosad_scouting_app/widgets/widgets.dart';

class PitInformation extends StatefulWidget {
  final DataContainer<String> currentTeamData = DataContainer("");

  PitInformation({Key? key}) : super(key: key);

  @override
  _PitInformationState createState() => _PitInformationState();
}

class _PitInformationState extends State<PitInformation>
    with CancelReportButton {
  late final TextEdit teamNumber;

  @override
  void initState() {
    teamNumber = TextEdit(
      title: "Team Number:",
      container: widget.currentTeamData,
      size: 30,
      lines: 1,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(title: "General Information"),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              teamNumber,
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                "Report id: $reportId",
                style: AppFont(size: 15, color: Colors.grey.shade700).getFont(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          getCancelReportButton(context),
          Align(
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
                setState(() {});

                if (widget.currentTeamData.value == "") {
                  showDialog(
                    context: context,
                    builder: (context) => PopupDialog(
                      context,
                      title: "Warning!",
                      body:
                          "You need to enter a team number before continuing.",
                      buttons: [
                        PopupDialogButton(
                          text: "OK",
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      ],
                    ),
                  );
                } else {
                  if (int.tryParse(widget.currentTeamData.value) == null) {
                    showDialog(
                      context: context,
                      builder: (context) => PopupDialog(
                        context,
                        title: "Warning!",
                        body: "You can only enter numbers.",
                        buttons: [
                          PopupDialogButton(
                            text: "OK",
                            onPressed: () => Navigator.of(context).pop(),
                          )
                        ],
                      ),
                    );
                  } else {
                    FocusScope.of(context).requestFocus(
                      FocusNode(),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => pages["pit"]!),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
