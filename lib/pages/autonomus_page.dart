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
      title: langEntries['exited_tarmac']![currentLang['i']],
      container: widget.robotMovedData,
    );
    ballsPickedFloorCounter = ScoreCounter(
      title: langEntries['picked_floor']![currentLang['i']],
      container: widget.ballsPickedFloorData,
    );
    ballsPickedFeederCounter = ScoreCounter(
      title: langEntries['picked_feeder']![currentLang['i']],
      container: widget.ballsPickedFeederData,
    );
    ballsMissedCounter = ScoreCounter(
      title: langEntries['missed']![currentLang['i']],
      container: widget.ballsMissedData,
    );
    lowerScoreCounter = ScoreCounter(
      title: langEntries['lower_hub']![currentLang['i']],
      container: widget.lowerScoreData,
    );
    upperScoreCounter = ScoreCounter(
      title: langEntries['upper_hub']![currentLang['i']],
      container: widget.upperScoreData,
    );
    notes = TextEdit(
      title: langEntries['additional_notes']![currentLang['i']],
      container: widget.notesData,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: langEntries['autonomus']![currentLang['i']],
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
          ballsPickedFeederCounter,
          ballsPickedFloorCounter,
          ballsMissedCounter,
          lowerScoreCounter,
          upperScoreCounter,
          notes,
        ],
      ),
    );
  }
}
