import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';
import 'package:hamosad_scouting_app/widgets/widgets.dart';

class AutonomusPage extends StatefulWidget {
  const AutonomusPage({Key? key}) : super(key: key);

  @override
  State<AutonomusPage> createState() => _AutonomusPageState();
}

class _AutonomusPageState extends State<AutonomusPage>
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
  final ToggleButton _robotMoved = const ToggleButton(
    title: "Has the robot moved?",
  );
  final TextEdit _notes = const TextEdit(title: "Additional Notes:");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: "Autonomus",
      ),
      floatingActionButton: Stack(
        children: [
          getLastPageButton(context),
          getNextPageButton(context, nextPage: const TeleopPage())
        ],
      ),
      body: WidgetList(
        children: [
          _robotMoved,
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
