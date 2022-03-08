import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';
import 'package:hamosad_scouting_app/widgets/widgets.dart';
import 'package:hamosad_scouting_app/misc/data_container.dart';

class EndgamePage extends StatefulWidget {
  EndgamePage({Key? key}) : super(key: key);

  final DataContainer<double> barClimbedData = DataContainer(0);
  final DataContainer<int> secondsClimbedData = DataContainer(0);
  final DataContainer<String> notesData = DataContainer("");

  @override
  State<EndgamePage> createState() => _EndgamePageState();
}

class _EndgamePageState extends State<EndgamePage>
    with LastPageButton, NextPageButton {
  late final OptionsSlider barClimbed;
  late final TextEdit notes;
  late final StopwatchTimer secondsClimbed;

  @override
  void initState() {
    barClimbed = OptionsSlider(
        title: langEntries['climbed_to_bar']![currentLang['i']],
        container: widget.barClimbedData,
        max: 4);
    secondsClimbed = StopwatchTimer(
      title: langEntries['bars_time'][currentLang['i']],
      secondsData: widget.secondsClimbedData,
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
        title: langEntries['endgame']![currentLang['i']],
      ),
      floatingActionButton: Stack(
        children: [
          getLastPageButton(context),
          getNextPageButton(context, nextPage: pages["summary"]!)
        ],
      ),
      body: WidgetList(
        children: [
          barClimbed,
          secondsClimbed,
          notes,
        ],
      ),
    );
  }
}
