import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';
import 'package:hamosad_scouting_app/widgets/widgets.dart';
import 'package:hamosad_scouting_app/misc/data_container.dart';

class SummaryPage extends StatefulWidget {
  SummaryPage({Key? key}) : super(key: key);

  final DataContainer<bool> allianceWonData = DataContainer(false);

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage>
    with LastPageButton, SubmitButton {
  late final ToggleButton allianceWon;

  @override
  void initState() {
    allianceWon = ToggleButton(
      title: "Did the alliance of the robot won?",
      container: widget.allianceWonData,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: "Report Summary",
      ),
      body: WidgetList(children: [
        allianceWon,
        Text(
          "Ranking points: ",
          style: AppFont(size: 22.5).getFont(),
        )
      ]),
      floatingActionButton: Stack(
        children: [getLastPageButton(context), getSubmitButton(context)],
      ),
    );
  }
}
