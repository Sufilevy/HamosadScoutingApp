import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/misc/string_container.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';
import 'package:hamosad_scouting_app/misc/database.dart';
import 'package:hamosad_scouting_app/widgets/widgets.dart';

int _selectedTeam = -1;
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
    _selectedTeam = -1;
  }

  @override
  State<GeneralInformationPage> createState() => _GeneralInformationPageState();
}

class _GeneralInformationPageState extends State<GeneralInformationPage>
    with CancelReportButton, NextPageButton {
  final List<String> _games =
      List<int>.generate(11, (i) => i + 1).map((v) => v.toString()).toList() +
          ["Eighth-Final", "Quarter-Final", "Semi-Final", "Final"];

  final AutonomusPage _nextPage = const AutonomusPage();
  late final DropdownMenu chooseGames;
  final StringContainer currentTeamNumber = StringContainer();
  late final TextEdit teamNumber;

  @override
  void initState() {
    super.initState();
    chooseGames = DropdownMenu(
        title: "Game Number:",
        items: _games,
        onChanged: (newValue) => setState(() {
              gameNumber = newValue;
              teams = getTeamsInGame(gameNumber: gameNumber);
            }));
    gameNumber = null;
    teamNumber = TextEdit(
      title: "Team Number:",
      container: currentTeamNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (["Eighth-Final", "Quarter-Final", "Semi-Final", "Final"]
        .contains(gameNumber)) {
      _selectedTeam = -1;
    }

    return Scaffold(
      appBar: PageAppBar(
        title: "General Information",
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        chooseGames,
        (["Eighth-Final", "Quarter-Final", "Semi-Final", "Final"]
                .contains(gameNumber))
            ? teamNumber
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                if (gameNumber != null && _selectedTeam != 0) {
                                  _selectedTeam = 0;
                                }
                              });
                            },
                            child: TeamButton(
                              label: teams[0],
                              selected: _selectedTeam == 0,
                              teamColor: Colors.blue,
                            )),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                if (gameNumber != null && _selectedTeam != 3) {
                                  _selectedTeam = 3;
                                }
                              });
                            },
                            child: TeamButton(
                              label: teams[3],
                              selected: _selectedTeam == 3,
                              teamColor: Colors.red,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                if (gameNumber != null && _selectedTeam != 1) {
                                  _selectedTeam = 1;
                                }
                              });
                            },
                            child: TeamButton(
                              label: teams[1],
                              selected: _selectedTeam == 1,
                              teamColor: Colors.blue,
                            )),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                if (gameNumber != null && _selectedTeam != 4) {
                                  _selectedTeam = 4;
                                }
                              });
                            },
                            child: TeamButton(
                              label: teams[4],
                              selected: _selectedTeam == 4,
                              teamColor: Colors.red,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                if (gameNumber != null && _selectedTeam != 2) {
                                  _selectedTeam = 2;
                                }
                              });
                            },
                            child: TeamButton(
                              label: teams[2],
                              selected: _selectedTeam == 2,
                              teamColor: Colors.blue,
                            )),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                if (gameNumber != null && _selectedTeam != 5) {
                                  _selectedTeam = 5;
                                }
                              });
                            },
                            child: TeamButton(
                              label: teams[5],
                              selected: _selectedTeam == 5,
                              teamColor: Colors.red,
                            )),
                      ],
                    ),
                  )
                ],
              ),
      ]),
      floatingActionButton: Stack(
        children: [
          getCancelReportButton(context),
          Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                heroTag: "forward",
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
                                    onPressed: () =>
                                        Navigator.of(context).pop())
                              ],
                            ));
                  } else {
                    if (["Eighth-Final", "Quarter-Final", "Semi-Final", "Final"]
                        .contains(gameNumber)) {
                      if (currentTeamNumber.value != null) {
                        if (int.tryParse(currentTeamNumber.value!) == null) {
                          showDialog(
                              context: context,
                              builder: (context) => PopupDialog(
                                    context,
                                    title: "Warning!",
                                    body: "You can only enter numbers.",
                                    buttons: [
                                      PopupDialogButton(
                                          text: "OK",
                                          onPressed: () =>
                                              Navigator.of(context).pop())
                                    ],
                                  ));
                        } else {
                          FocusScope.of(context).requestFocus(FocusNode());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => _nextPage));
                        }
                      } else {
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
                                        onPressed: () =>
                                            Navigator.of(context).pop())
                                  ],
                                ));
                      }
                    } else if (_selectedTeam == -1) {
                      showDialog(
                          context: context,
                          builder: (context) => PopupDialog(
                                context,
                                title: "Warning!",
                                body:
                                    "You need to choose a team before continuing.",
                                buttons: [
                                  PopupDialogButton(
                                      text: "OK",
                                      onPressed: () =>
                                          Navigator.of(context).pop())
                                ],
                              ));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => _nextPage));
                    }
                  }
                },
              ))
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
        border: Border.all(width: 1.0, color: _teamColor),
        color: (_selected) ? _teamColor : Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
