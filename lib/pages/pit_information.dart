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
      title: langEntries['team_number'][currentLang['i']],
      container: widget.currentTeamData,
      size: 30,
      lines: 1,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: langEntries['info'][currentLang['i']],
      ),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 2, 8),
                  child: Text(
                    langEntries['report_id'][currentLang['i']],
                    style: AppFont(size: 15, color: Colors.grey.shade700)
                        .getFont(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 8, 8, 8),
                  child: Text(
                    reportId,
                    style: AppFont(size: 15, color: Colors.grey.shade700)
                        .getFont(),
                  ),
                ),
              ],
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
              tooltip: langEntries['next_page'][currentLang['i']],
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
                      title: langEntries['warning'][currentLang['i']],
                      body: langEntries['team_warning'][currentLang['i']],
                      buttons: [
                        PopupDialogButton(
                          text: langEntries['ok'][currentLang['i']],
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
                        title: langEntries['warning'][currentLang['i']],
                        body: langEntries['numbers_warning'][currentLang['i']],
                        buttons: [
                          PopupDialogButton(
                            text: langEntries['ok'][currentLang['i']],
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
