import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';
import 'package:hamosad_scouting_app/widgets/widgets.dart';
import 'package:hamosad_scouting_app/misc/data_container.dart';

class TeleopPage extends StatefulWidget {
  TeleopPage({Key? key}) : super(key: key);

  final DataContainer<bool> cantShootDynamicallyData = DataContainer(false);
  final DataContainer<String> anchorPointData = DataContainer("");
  final DataContainer<int> ballsPickedFloorData = DataContainer(0);
  final DataContainer<int> ballsPickedFeederData = DataContainer(0);
  final DataContainer<int> ballsMissedData = DataContainer(0);
  final DataContainer<int> lowerScoreData = DataContainer(0);
  final DataContainer<int> upperScoreData = DataContainer(0);
  final DataContainer<String> notesData = DataContainer("");

  @override
  State<TeleopPage> createState() => _TeleopPageState();
}

class _TeleopPageState extends State<TeleopPage>
    with LastPageButton, NextPageButton {
  late final ToggleButton cantShootDynamically;
  late final TextEdit anchorPoint;
  late final ScoreCounter ballsPickedFloorCounter;
  late final ScoreCounter ballsPickedFeederCounter;
  late final ScoreCounter ballsMissedCounter;
  late final ScoreCounter lowerScoreCounter;
  late final ScoreCounter upperScoreCounter;
  late final TextEdit notes;

  @override
  void initState() {
    cantShootDynamically = ToggleButton(
      title: langEntries['cant_shoot_dynamically'][currentLang['i']],
      container: widget.cantShootDynamicallyData,
      onChanged: (newValue) {
        setState(
          () {
            widget.cantShootDynamicallyData.value = newValue;
          },
        );
      },
    );
    anchorPoint = TextEdit(
      title: langEntries['anchor_point'][currentLang['i']],
      container: widget.anchorPointData,
      lines: 1,
      titleInLine: true,
    );
    ballsPickedFloorCounter = ScoreCounter(
      title: langEntries['picked_floor'][currentLang['i']],
      container: widget.ballsPickedFloorData,
    );
    ballsPickedFeederCounter = ScoreCounter(
      title: langEntries['picked_feeder'][currentLang['i']],
      container: widget.ballsPickedFeederData,
    );
    ballsMissedCounter = ScoreCounter(
      title: langEntries['missed'][currentLang['i']],
      container: widget.ballsMissedData,
    );
    lowerScoreCounter = ScoreCounter(
      title: langEntries['lower_hub'][currentLang['i']],
      container: widget.lowerScoreData,
    );
    upperScoreCounter = ScoreCounter(
      title: langEntries['upper_hub'][currentLang['i']],
      container: widget.upperScoreData,
    );
    notes = TextEdit(
      title: langEntries['additional_notes'][currentLang['i']],
      container: widget.notesData,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: langEntries['teleop'][currentLang['i']],
      ),
      floatingActionButton: Stack(
        children: [
          getLastPageButton(context),
          getNextPageButton(context, nextPage: pages["endgame"]!)
        ],
      ),
      body: WidgetList(
        children: [
          cantShootDynamically,
          widget.cantShootDynamicallyData.value ? anchorPoint : null,
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
