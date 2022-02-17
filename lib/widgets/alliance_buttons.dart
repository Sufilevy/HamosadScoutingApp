import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/misc/data_container.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';

class AllianceButtons extends StatefulWidget {
  final DataContainer<String> selectedAllianceData;

  const AllianceButtons({
    Key? key,
    required DataContainer<String> container,
  })  : selectedAllianceData = container,
        super(key: key);

  @override
  _AllianceButtonsState createState() => _AllianceButtonsState();
}

class _AllianceButtonsState extends State<AllianceButtons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(width: 1, color: Colors.blue),
              color: (widget.selectedAllianceData.value == "blue")
                  ? Colors.blue
                  : Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TextButton(
                onPressed: () => setState(() {
                  widget.selectedAllianceData.value = "blue";
                }),
                child: Text(
                  "Blue Alliance",
                  style: AppFont(
                          color: (widget.selectedAllianceData.value == "blue")
                              ? Theme.of(context).canvasColor
                              : Colors.blue,
                          size: 30)
                      .getFont(),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(width: 1, color: Colors.red),
              color: (widget.selectedAllianceData.value == "red")
                  ? Colors.red
                  : Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TextButton(
                onPressed: () => setState(() {
                  widget.selectedAllianceData.value = "red";
                }),
                child: Text(
                  "Red Alliance",
                  style: AppFont(
                          color: (widget.selectedAllianceData.value == "red")
                              ? Theme.of(context).canvasColor
                              : Colors.red,
                          size: 30)
                      .getFont(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
