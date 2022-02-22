import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/misc/data_container.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';

class ToggleButtons extends StatefulWidget {
  final String title;
  final List<String> titles;
  final DataContainer<List<int>> toggledData;

  const ToggleButtons({
    Key? key,
    required this.title,
    required this.titles,
    required DataContainer<List<int>> container,
  })  : toggledData = container,
        super(key: key);

  @override
  _ToggleButtonsState createState() => _ToggleButtonsState();
}

class _ToggleButtonsState extends State<ToggleButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.title,
          style: AppFont(size: 27).getFont(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.titles.length,
            (index) => Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Transform.scale(
                scale: 1.35,
                child: Checkbox(
                  activeColor: accentColor,
                  side: BorderSide(color: accentColor),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  value: widget.toggledData.value.contains(index),
                  onChanged: (newValue) => setState(
                    () => newValue ?? false
                        ? widget.toggledData.value.add(index)
                        : widget.toggledData.value.remove(index),
                  ),
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.titles.length,
            (index) => Padding(
              padding: const EdgeInsets.fromLTRB(34, 0, 34, 0),
              child: Text(
                widget.titles[index],
                style: AppFont(size: 20).getFont(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
