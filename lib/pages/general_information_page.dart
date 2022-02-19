import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/misc/data_container.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';
import 'package:hamosad_scouting_app/misc/database.dart';
import 'package:hamosad_scouting_app/widgets/alliance_buttons.dart';
import 'package:hamosad_scouting_app/widgets/widgets.dart';

DataContainer<int> selectedTeam = DataContainer(-1);
String? gameNumber;
List<String> teams = [
  "0000",
  "0000",
  "0000",
  "0000",
  "0000",
  "0000",
];

class GeneralInformationPage extends StatefulWidget {
  GeneralInformationPage({Key? key}) : super(key: key) {
    selectedTeam.value = -1;
  }

  final DataContainer<String> currentTeamData = DataContainer("");
  final DataContainer<String> allianceData = DataContainer("blue");
  final DataContainer<String> gameNumberData = DataContainer("");

  @override
  State<GeneralInformationPage> createState() => _GeneralInformationPageState();
}

class _GeneralInformationPageState extends State<GeneralInformationPage>
    with CancelReportButton, NextPageButton {
  final List<String> games = List<int>.generate(11, (i) => i + 1)
          .map(
            (v) => v.toString(),
          )
          .toList() +
      ["Eighth-Final", "Quarter-Final", "Semi-Final", "Final"];

  late final DropdownMenu chooseGames;
  late final TextEdit teamNumber;
  late final AllianceButtons allianceButtons;

  @override
  void initState() {
    super.initState();
    chooseGames = DropdownMenu(
      title: "Game Number:",
      items: games,
      onChanged: (newValue) => setState(
        () {
          gameNumber = newValue;
          widget.gameNumberData.value = newValue;
          if (gameNumber != null && int.tryParse(gameNumber!) != null) {
            List<String> temp = [];
            for (var value in gameTeams[int.parse(gameNumber!) - 1]) {
              temp.add(value.toString());
            }
            teams = temp;
          } else {
            teams = [
              "0000",
              "0000",
              "0000",
              "0000",
              "0000",
              "0000",
            ];
          }
        },
      ),
    );
    gameNumber = null;
    teamNumber = TextEdit(
      title: "Team Number:",
      container: widget.currentTeamData,
      size: 30,
      lines: 1,
    );
    allianceButtons = AllianceButtons(container: widget.allianceData);
  }

  @override
  Widget build(BuildContext context) {
    if (["Eighth-Final", "Quarter-Final", "Semi-Final", "Final"]
        .contains(gameNumber)) {
      selectedTeam.value = -1;
    }

    return Scaffold(
      appBar: PageAppBar(
        title: "General Information",
      ),
      body: Center(
        child: WidgetList(
          children: [
            chooseGames,
            if (["Eighth-Final", "Quarter-Final", "Semi-Final", "Final"]
                .contains(gameNumber))
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: teamNumber,
                  ),
                  allianceButtons
                ],
              )
            else
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(
                              () {
                                if (gameNumber != null &&
                                    selectedTeam.value != 0) {
                                  selectedTeam.value = 0;
                                  widget.currentTeamData.value = teams[0];
                                  widget.allianceData.value = "blue";
                                }
                              },
                            );
                          },
                          child: TeamButton(
                            label: teams[0],
                            selected: selectedTeam.value == 0,
                            teamColor: Colors.blue,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(
                              () {
                                if (gameNumber != null &&
                                    selectedTeam.value != 3) {
                                  selectedTeam.value = 3;
                                  widget.currentTeamData.value = teams[3];
                                  widget.allianceData.value = "red";
                                }
                              },
                            );
                          },
                          child: TeamButton(
                            label: teams[3],
                            selected: selectedTeam.value == 3,
                            teamColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(
                              () {
                                if (gameNumber != null &&
                                    selectedTeam.value != 1) {
                                  selectedTeam.value = 1;
                                  widget.currentTeamData.value = teams[1];
                                  widget.allianceData.value = "blue";
                                }
                              },
                            );
                          },
                          child: TeamButton(
                            label: teams[1],
                            selected: selectedTeam.value == 1,
                            teamColor: Colors.blue,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(
                              () {
                                if (gameNumber != null &&
                                    selectedTeam.value != 4) {
                                  selectedTeam.value = 4;
                                  widget.currentTeamData.value = teams[4];
                                  widget.allianceData.value = "red";
                                }
                              },
                            );
                          },
                          child: TeamButton(
                            label: teams[4],
                            selected: selectedTeam.value == 4,
                            teamColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(
                              () {
                                if (gameNumber != null &&
                                    selectedTeam.value != 2) {
                                  selectedTeam.value = 2;
                                  widget.currentTeamData.value = teams[2];
                                  widget.allianceData.value = "blue";
                                }
                              },
                            );
                          },
                          child: TeamButton(
                            label: teams[2],
                            selected: selectedTeam.value == 2,
                            teamColor: Colors.blue,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(
                              () {
                                if (gameNumber != null &&
                                    selectedTeam.value != 5) {
                                  selectedTeam.value = 5;
                                  widget.currentTeamData.value = teams[5];
                                  widget.allianceData.value = "red";
                                }
                              },
                            );
                          },
                          child: TeamButton(
                            label: teams[5],
                            selected: selectedTeam.value == 5,
                            teamColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
          ],
        ),
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

                if (gameNumber == null) {
                  showDialog(
                    context: context,
                    builder: (context) => PopupDialog(
                      context,
                      title: "Warning!",
                      body:
                          "You need to choose a game number before continuing.",
                      buttons: [
                        PopupDialogButton(
                          text: "OK",
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      ],
                    ),
                  );
                } else {
                  if (["Eighth-Final", "Quarter-Final", "Semi-Final", "Final"]
                      .contains(gameNumber)) {
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
                          MaterialPageRoute(
                              builder: (context) => pages["autonomus"]!),
                        );
                      }
                    }
                  } else if (selectedTeam.value == -1) {
                    showDialog(
                      context: context,
                      builder: (context) => PopupDialog(
                        context,
                        title: "Warning!",
                        body: "You need to choose a team before continuing.",
                        buttons: [
                          PopupDialogButton(
                            text: "OK",
                            onPressed: () => Navigator.of(context).pop(),
                          )
                        ],
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => pages["autonomus"]!),
                    );
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class TeamButton extends StatelessWidget {
  const TeamButton(
      {required String label,
      required bool selected,
      required MaterialColor teamColor,
      Key? key})
      : _label = label,
        _selected = selected,
        _teamColor = teamColor,
        super(key: key);

  final String _label;
  final bool _selected;
  final MaterialColor _teamColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(width: 1, color: _teamColor),
        color: (_selected) ? _teamColor : Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          _label,
          style: AppFont(
                  color:
                      (_selected) ? Theme.of(context).canvasColor : _teamColor,
                  size: 30)
              .getFont(),
        ),
      ),
    );
  }
}
