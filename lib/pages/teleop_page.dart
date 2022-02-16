import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';
import 'package:hamosad_scouting_app/widgets/widgets.dart';

class TeleopPage extends StatefulWidget {
  const TeleopPage({Key? key}) : super(key: key);

  @override
  State<TeleopPage> createState() => _TeleopPageState();
}

class _TeleopPageState extends State<TeleopPage>
    with LastPageButton, NextPageButton {
  final ScoreCounter _ballsPickedFloorCounter =
      const ScoreCounter(title: "Balls Picked From Floor:");
  final ScoreCounter _ballsPickedFeederCounter =
      const ScoreCounter(title: "Balls Picked From Feeder:");
  final ScoreCounter _ballsShotCounter = const ScoreCounter(
    title: "Balls Shot:",
  );
  final ScoreCounter _lowerScoreCounter = const ScoreCounter(
    title: "Lower Hub In:",
  );
  final ScoreCounter _upperScoreCounter = const ScoreCounter(
    title: "Upper Hub In:",
  );
  final ToggleButton _robotShootsWhileMoving = const ToggleButton(
    title: "Can the robot shoot while moving?",
  );
  final TextEdit _notes = const TextEdit(title: "Additional Notes:");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: "Teleop",
      ),
      floatingActionButton: Stack(
        children: [
          getLastPageButton(context),
          getNextPageButton(context, nextPage: const EndgamePage())
        ],
      ),
      body: WidgetList(
        children: [
          _robotShootsWhileMoving,
          _ballsPickedFloorCounter,
          _ballsPickedFeederCounter,
          _ballsShotCounter,
          _lowerScoreCounter,
          _upperScoreCounter,
          _notes,
        ],
      ),
    );
  }
}
