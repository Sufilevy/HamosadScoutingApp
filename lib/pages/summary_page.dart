import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';
import 'package:hamosad_scouting_app/widgets/widgets.dart';
import 'package:hamosad_scouting_app/misc/data_container.dart';

class SummaryPage extends StatefulWidget {
  SummaryPage({Key? key}) : super(key: key);

  final DataContainer<double> robotFocusData = DataContainer(1);
  final DataContainer<int> totalScoreData = DataContainer(0);

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage>
    with LastPageButton, SubmitButton {
  late final OptionsSlider robotFocus = OptionsSlider(
    title: "Robot's main focus:",
    container: widget.robotFocusData,
    min: 1,
    max: 5,
    leftTitle: "< Defending",
    rightTitle: "Scoring >",
  );
  int endgameScore = 0, autonomusScore = 0, teleopScore = 0;

  @override
  void initState() {
    switch (pages["endgame"].barClimbedData.value.toInt()) {
      case 0:
        endgameScore = 0;
        break;
      case 1:
        endgameScore = 4;
        break;
      case 2:
        endgameScore = 6;
        break;
      case 3:
        endgameScore = 10;
        break;
      case 4:
        endgameScore = 15;
        break;
      default:
        endgameScore = 0;
        break;
    }
    autonomusScore = pages["autonomus"].lowerScoreData.value * 2 +
            pages["autonomus"].upperScoreData.value * 4 +
            (pages["autonomus"].robotMovedData.value
        ? 2
        : 0);
    teleopScore = pages["teleop"].lowerScoreData.value +
        pages["teleop"].upperScoreData.value * 2;

    widget.totalScoreData.value = autonomusScore + teleopScore + endgameScore;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: "Report Summary",
      ),
      body: WidgetList(children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: robotFocus,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "Autonomus Score:   $autonomusScore",
            style: AppFont(size: 25).getFont(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "Teleop Score:   $teleopScore",
            style: AppFont(size: 25).getFont(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "Endgame Score:   $endgameScore",
            style: AppFont(size: 25).getFont(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            "Total Score:   ${widget.totalScoreData.value}",
            style: AppFont(size: 30, fontWeight: FontWeight.bold).getFont(),
          ),
        )
      ]),
      floatingActionButton: Stack(
        children: [getLastPageButton(context), getSubmitButton(context)],
      ),
    );
  }
}
