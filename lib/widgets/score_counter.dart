import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/misc/data_container.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';

class ScoreCounter extends StatefulWidget {
  final String title;
  final int modifier;
  final DataContainer<int> scoreData;

  const ScoreCounter(
      {Key? key,
      required this.title,
      required DataContainer<int> container,
      this.modifier = 1})
      : scoreData = container,
        super(key: key);

  @override
  _ScoreCounterState createState() => _ScoreCounterState();
}

class _ScoreCounterState extends State<ScoreCounter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            widget.title,
            style: AppFont(size: 27).getFont(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(accentColor),
                  shape: MaterialStateProperty.all<CircleBorder>(CircleBorder(
                    side: BorderSide(width: 1, color: accentColor),
                  )),
                ),
                onPressed: () => {
                  setState(
                    () => {
                      if (widget.scoreData.value - widget.modifier >= 0)
                        widget.scoreData.value -= widget.modifier
                    },
                  )
                },
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    (widget.modifier * -1).toString(),
                    style:
                        AppFont(color: Theme.of(context).canvasColor, size: 25)
                            .getFont(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    border: Border.all(color: accentColor, width: 2),
                  ),
                  child: Text(
                    widget.scoreData.value.toString().padLeft(4, '0'),
                    style: AppFont(size: 27).getFont(),
                  ),
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(accentColor),
                  shape: MaterialStateProperty.all<CircleBorder>(CircleBorder(
                    side: BorderSide(width: 1, color: accentColor),
                  )),
                ),
                onPressed: () =>
                    {setState(() => widget.scoreData.value += widget.modifier)},
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    '+' + widget.modifier.toString(),
                    style:
                        AppFont(color: Theme.of(context).canvasColor, size: 25)
                            .getFont(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
