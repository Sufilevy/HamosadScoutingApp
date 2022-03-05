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
      title: langEntries['name_prompt'][currentLang['i']],
      titleInLine: true,
      container: widget.reporterNameData,
      lines: 1,
      size: 20,
      color: Colors.grey.shade700,
    );
    reporterTeam = TextEdit(
      title: langEntries['team_prompt'][currentLang['i']],
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
    bool keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenSize = (screenHeight * screenWidth) / 1000;

    return Scaffold(
      appBar: PageAppBar(
        title: "",
        buttons: [
          GestureDetector(
            child: Icon(
              Icons.library_books_rounded,
              color: accentColor,
              size: 35,
            ),
            onTap: () {
              SystemSound.play(SystemSoundType.click);
              showDialog(
                context: context,
                builder: (context) => PopupDialog(
                  context,
                  title: langEntries['report_type'][currentLang['i']],
                  body: langEntries['report_type_text_1'][currentLang['i']] +
                      "\n\n" +
                      langEntries['report_type_text_2'][currentLang['i']] +
                      "\n\n" +
                      langEntries['report_type_text_3'][currentLang['i']],
                  buttons: [
                    PopupDialogButton(
                      text: langEntries['report_type_pit'][currentLang['i']],
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() => reportType = ReportType.pit);
                      },
                    ),
                    PopupDialogButton(
                      text: langEntries['report_type_game'][currentLang['i']],
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() => reportType = ReportType.game);
                      },
                    )
                  ],
                ),
              );
            },
          ),
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
              Icons.help_center_rounded,
              color: accentColor,
              size: 35,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpPage()),
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
              flex: 8,
              child: Column(
                children: [
                  SizedBox(height: screenSize / 15),
                  reporterName,
                  SizedBox(height: screenSize / 20),
                  reporterTeam,
                ],
              ),
            ),
            Expanded(
              flex: 11,
              child: Column(
                children: [
                  Text(
                    '''${langEntries['new_report_1'][currentLang['i']]}
${reportType == ReportType.game ? langEntries['game_report'][currentLang['i']] : langEntries['pit_report'][currentLang['i']]} ${langEntries['new_report_2'][currentLang['i']]}''',
                    textAlign: TextAlign.center,
                    style: AppFont(
                            size: screenSize / 7.2, color: Colors.grey.shade700)
                        .getFont(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_box_outlined),
                    tooltip: "Create a new report",
                    iconSize: screenSize / 2.75,
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
                            title: langEntries['warning'][currentLang['i']],
                            body: langEntries['name_warning'][currentLang['i']],
                            buttons: [
                              PopupDialogButton(
                                text: langEntries['ok'][currentLang['i']],
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
                            title: langEntries['warning'][currentLang['i']],
                            body: langEntries['your_team_warning']
                                [currentLang['i']],
                            buttons: [
                              PopupDialogButton(
                                text: langEntries['ok'][currentLang['i']],
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
                            title: langEntries['warning'][currentLang['i']],
                            body: langEntries['numbers_warning']
                                [currentLang['i']],
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

                        pages.addEntries(reportType == ReportType.game
                            ? {
                                "info": GeneralInformationPage(),
                                "autonomus": AutonomusPage(),
                                "teleop": TeleopPage(),
                                "endgame": EndgamePage(),
                                "summary": SummaryPage(),
                              }.entries
                            : {
                                "pit_info": PitInformation(),
                                "pit": PitReport(),
                              }.entries);

                        creatingNewReport = true;
                        reportId = generateReportId();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => reportType == ReportType.game
                                ? pages["info"]
                                : pages["pit_info"],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            !keyboardVisible
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          if (lastReport == null) {
                            showDialog(
                              context: context,
                              builder: (context) => PopupDialog(
                                context,
                                title: langEntries['warning'][currentLang['i']],
                                body: langEntries['no_report_warning']
                                    [currentLang['i']],
                                buttons: [
                                  PopupDialogButton(
                                    text: langEntries['ok'][currentLang['i']],
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
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
                                builder: (context) =>
                                    lastReport[reportId]["drivingType"] != null
                                        ? pages["pit_info"]
                                        : pages["info"],
                              ),
                            );
                          }
                        },
                        child: Text(
                          langEntries['update_report'][currentLang['i']],
                          textAlign: TextAlign.center,
                          style: AppFont(
                                  size: screenSize / 13,
                                  color: Colors.grey.shade700)
                              .getFont(),
                        ),
                      ),
                      Icon(
                        Icons.replay_rounded,
                        color: Colors.grey.shade700,
                        size: screenSize / 15,
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
