import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';
import 'package:hamosad_scouting_app/widgets/widgets.dart';
import 'package:hamosad_scouting_app/misc/data_container.dart';

class TeleopPage extends StatefulWidget {
  TeleopPage({Key? key}) : super(key: key);

  final DataContainer<bool> canShootWhileMovingData = DataContainer(false);
  final DataContainer<bool> canPickMultipleData = DataContainer(false);
  final DataContainer<bool> canShootDynamicallyData = DataContainer(false);

  final DataContainer<int> ballsPickedFloorData = DataContainer(0);
  final DataContainer<int> ballsPickedFeederData = DataContainer(0);
  final DataContainer<int> ballsShotData = DataContainer(0);
  final DataContainer<int> lowerScoreData = DataContainer(0);
  final DataContainer<int> upperScoreData = DataContainer(0);
  final DataContainer<double> robotHubFocusData = DataContainer(1.0);
  final DataContainer<String> notesData = DataContainer("");

  @override
  State<TeleopPage> createState() => _TeleopPageState();
}

class _TeleopPageState extends State<TeleopPage>
    with LastPageButton, NextPageButton {
  late final ToggleButton canShootWhileMoving;
  late final ToggleButton canPickMultiple;
  late final ToggleButton canShootDynamically;
  late final ScoreCounter ballsPickedFloorCounter;
  late final ScoreCounter ballsPickedFeederCounter;
  late final ScoreCounter ballsShotCounter;
  late final ScoreCounter lowerScoreCounter;
  late final ScoreCounter upperScoreCounter;
  late final OptionsSlider robotHubFocus;
  late final TextEdit notes;

  @override
  void initState() {
    canShootWhileMoving = ToggleButton(
      title: "Can the robot shoot while moving?",
      container: widget.canShootWhileMovingData,
    );
    canShootDynamically = ToggleButton(
      title: "Can the robot shoot from multiple places?",
      container: widget.canShootDynamicallyData,
    );
    canPickMultiple = ToggleButton(
      title: "Can the robot pick up more than one ball at once?",
      container: widget.canPickMultipleData,
    );
    ballsPickedFloorCounter = ScoreCounter(
      title: "Balls picked from floor:",
      container: widget.ballsPickedFloorData,
    );
    ballsPickedFeederCounter = ScoreCounter(
      title: "Balls picked from feeder:",
      container: widget.ballsPickedFeederData,
    );
    ballsShotCounter = ScoreCounter(
      title: "Balls shot:",
      container: widget.ballsShotData,
    );
    lowerScoreCounter = ScoreCounter(
      title: "Balls entered the lower hub:",
      container: widget.lowerScoreData,
    );
    upperScoreCounter = ScoreCounter(
      title: "Balls entered the upper hub:",
      container: widget.upperScoreData,
    );

    robotHubFocus = OptionsSlider(
      title: "Robot's main hub focus:",
      container: widget.robotHubFocusData,
      min: 1,
      max: 5,
      leftTitle: "< Lower",
      rightTitle: "Upper >",
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
        title: "Teleop",
      ),
      floatingActionButton: Stack(
        children: [
          getLastPageButton(context),
          getNextPageButton(context, nextPage: pages["endgame"]!)
        ],
      ),
      body: WidgetList(
        children: [
          canShootWhileMoving,
          canShootDynamically,
          canPickMultiple,
          ballsPickedFloorCounter,
          ballsPickedFeederCounter,
          ballsShotCounter,
          lowerScoreCounter,
          upperScoreCounter,
          robotHubFocus,
          notes,
        ],
      ),
    );
  }
}
