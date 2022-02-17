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
    title: "Robot's Main Focus:",
    container: widget.robotFocusData,
    min: 1,
    max: 5,
    leftTitle: "< Defending",
    rightTitle: "Scoring >",
  );

  @override
  void initState() {
    int climbingPoints;
    switch (pages["endgame"].barClimbedData.value.toInt()) {
      case 0:
        climbingPoints = 0;
        break;
      case 1:
        climbingPoints = 4;
        break;
      case 2:
        climbingPoints = 6;
        break;
      case 3:
        climbingPoints = 10;
        break;
      case 4:
        climbingPoints = 15;
        break;
      default:
        climbingPoints = 0;
        break;
    }

    widget.totalScoreData.value =
        ((pages["autonomus"].robotMovedData.value ? 2 : 0) +
                (pages["autonomus"].lowerScoreData.value * 2) +
                (pages["autonomus"].upperScoreData.value * 4) +
                (pages["teleop"].lowerScoreData.value * 1) +
                (pages["teleop"].upperScoreData.value * 2) +
                climbingPoints)
            .toInt();

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
