import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hamosad_scouting_app/misc/data_container.dart';
import 'package:hamosad_scouting_app/misc/database.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';
import 'package:hamosad_scouting_app/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  final DataContainer<String> reporterNameData = DataContainer("");
  final DataContainer<String> reporterTeamData = DataContainer("");

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEdit reporterName;
  late final TextEdit reporterTeam;

  @override
  void initState() {
    reporterName = TextEdit(
      title: "Enter your name...",
      titleInLine: true,
      container: widget.reporterNameData,
      lines: 1,
      size: 20,
      color: Colors.grey.shade700,
    );
    reporterTeam = TextEdit(
      title: "Enter your team number...",
      titleInLine: true,
      container: widget.reporterTeamData,
      lines: 1,
      size: 20,
      color: Colors.grey.shade700,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: "",
        buttons: [
          GestureDetector(
            child: Icon(
              Icons.history_rounded,
              color: accentColor,
              size: 35,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryPage()),
              );
              SystemSound.play(SystemSoundType.click);
            },
          ),
          GestureDetector(
            child: Icon(
              Icons.info_outline_rounded,
              color: accentColor,
              size: 35,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
              SystemSound.play(SystemSoundType.click);
            },
          ),
        ],
        showLogo: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  reporterName,
                  const SizedBox(height: 20),
                  reporterTeam,
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Create a\nnew report",
                    textAlign: TextAlign.center,
                    style: AppFont(size: 45, color: Colors.grey.shade700)
                        .getFont(),
                  ),
                  const SizedBox(height: 20),
                  IconButton(
                    icon: const Icon(Icons.add_box_outlined),
                    tooltip: "Create a new report",
                    iconSize: 100,
                    color: Colors.grey.shade700,
                    onPressed: () {
                      widget.reporterNameData.value =
                          reporterName.textData.value;
                      widget.reporterTeamData.value =
                          reporterTeam.textData.value;
                      if (widget.reporterNameData.value == "") {
                        showDialog(
                          context: context,
                          builder: (context) => PopupDialog(
                            context,
                            title: "Warning!",
                            body: "You need to enter your name.",
                            buttons: [
                              PopupDialogButton(
                                text: "OK",
                                onPressed: () => Navigator.of(context).pop(),
                              )
                            ],
                          ),
                        );
                      } else if (widget.reporterTeamData.value == "") {
                        showDialog(
                          context: context,
                          builder: (context) => PopupDialog(
                            context,
                            title: "Warning!",
                            body: "You need to enter your team number.",
                            buttons: [
                              PopupDialogButton(
                                text: "OK",
                                onPressed: () => Navigator.of(context).pop(),
                              )
                            ],
                          ),
                        );
                      } else if (int.tryParse(widget.reporterTeamData.value) ==
                          null) {
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

                        pages.addEntries({
                          "info": GeneralInformationPage(),
                          "autonomus": AutonomusPage(),
                          "teleop": TeleopPage(),
                          "endgame": EndgamePage(),
                          "summary": SummaryPage(),
                        }.entries);

                        creatingNewReport = true;
                        reportId = generateReportId();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => pages["info"]!,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      if (lastReport == null) {
                        showDialog(
                          context: context,
                          builder: (context) => PopupDialog(
                            context,
                            title: "Warning!",
                            body:
                                "There is no report to edit, please create a new one.",
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

                        creatingNewReport = false;

                        reportId = lastReport.keys.first;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => pages["info"]!,
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Update last report",
                      textAlign: TextAlign.center,
                      style: AppFont(size: 22.5, color: Colors.grey.shade700)
                          .getFont(),
                    ),
                  ),
                  Icon(
                    Icons.replay_rounded,
                    color: Colors.grey.shade700,
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
