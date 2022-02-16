import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';
import 'package:hamosad_scouting_app/widgets/widgets.dart';

class EndgamePage extends StatefulWidget {
  const EndgamePage({Key? key}) : super(key: key);

  @override
  State<EndgamePage> createState() => _EndgamePageState();
}

class _EndgamePageState extends State<EndgamePage>
    with LastPageButton, NextPageButton {
  final OptionsSlider _bars =
      const OptionsSlider(title: "Robot has climbed to bar:", max: 4);
  final TextEdit _notes = const TextEdit(title: "Additional Notes:");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: "Endgame",
      ),
      floatingActionButton: Stack(
        children: [
          getLastPageButton(context),
          getNextPageButton(context, nextPage: const SummaryPage())
        ],
      ),
      body: WidgetList(
        children: [_bars, _notes],
      ),
    );
  }
}
