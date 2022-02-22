import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/misc/data_container.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';
import 'package:hamosad_scouting_app/widgets/widgets.dart';

class AutonomusPage extends StatefulWidget {
  AutonomusPage({Key? key}) : super(key: key);

  final DataContainer<bool> robotMovedData = DataContainer(false);
  final DataContainer<int> ballsPickedFloorData = DataContainer(0);
  final DataContainer<int> ballsPickedFeederData = DataContainer(0);
  final DataContainer<int> ballsMissedData = DataContainer(0);
  final DataContainer<int> lowerScoreData = DataContainer(0);
  final DataContainer<int> upperScoreData = DataContainer(0);
  final DataContainer<String> notesData = DataContainer("");

  @override
  State<AutonomusPage> createState() => _AutonomusPageState();
}

class _AutonomusPageState extends State<AutonomusPage>
    with LastPageButton, NextPageButton {
  late final ToggleButton robotMoved;
  late final ScoreCounter ballsPickedFloorCounter;
  late final ScoreCounter ballsPickedFeederCounter;
  late final ScoreCounter ballsMissedCounter;
  late final ScoreCounter lowerScoreCounter;
  late final ScoreCounter upperScoreCounter;
  late final TextEdit notes;

  @override
  void initState() {
    robotMoved = ToggleButton(
      title: "Has the robot exited the taramac?",
      container: widget.robotMovedData,
    );
    ballsPickedFloorCounter = ScoreCounter(
      title: "Balls picked from floor:",
      container: widget.ballsPickedFloorData,
    );
    ballsPickedFeederCounter = ScoreCounter(
      title: "Balls picked from feeder:",
      container: widget.ballsPickedFeederData,
    );
    ballsMissedCounter = ScoreCounter(
      title: "Balls missed:",
      container: widget.ballsMissedData,
    );
    lowerScoreCounter = ScoreCounter(
      title: "Balls entered the lower hub:",
      container: widget.lowerScoreData,
    );
    upperScoreCounter = ScoreCounter(
      title: "Balls entered the upper hub:",
      container: widget.upperScoreData,
    );
    notes = TextEdit(
      title: "Additional Notes:",
      container: widget.notesData,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: "Autonomus",
      ),
      floatingActionButton: Stack(
        children: [
          getLastPageButton(context),
          getNextPageButton(context, nextPage: pages["teleop"]!),
        ],
      ),
      body: WidgetList(
        children: [
          robotMoved,
          ballsPickedFloorCounter,
          ballsPickedFeederCounter,
          ballsMissedCounter,
          lowerScoreCounter,
          upperScoreCounter,
          notes,
        ],
      ),
    );
  }
}
