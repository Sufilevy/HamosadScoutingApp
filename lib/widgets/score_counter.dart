import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';

class ScoreCounter extends StatefulWidget {
  final String _title;

  const ScoreCounter({Key? key, required String title, int modifier = 1})
      : _title = title,
        _modifier = modifier,
        super(key: key);

  final int _modifier;

  @override
  _ScoreCounterState createState() => _ScoreCounterState();
}

class _ScoreCounterState extends State<ScoreCounter> {
  int _score = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            widget._title,
            style: AppFont(color: accentColor, size: 27).getFont(),
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
                      shape: MaterialStateProperty.all<CircleBorder>(
                          CircleBorder(
                              side: BorderSide(width: 1, color: accentColor)))),
                  onPressed: () => {
                        setState(
                          () => {
                            if (_score - widget._modifier >= 0)
                              _score -= widget._modifier
                          },
                        )
                      },
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      (widget._modifier * -1).toString(),
                      style: AppFont(
                              color: Theme.of(context).canvasColor, size: 25)
                          .getFont(),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      border: Border.all(color: accentColor, width: 2)),
                  child: Text(
                    _score.toString().padLeft(4, '0'),
                    style: AppFont(color: accentColor, size: 27).getFont(),
                  ),
                ),
              ),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(accentColor),
                      shape: MaterialStateProperty.all<CircleBorder>(
                          CircleBorder(
                              side: BorderSide(width: 1, color: accentColor)))),
                  onPressed: () => {setState(() => _score += widget._modifier)},
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      '+' + widget._modifier.toString(),
                      style: AppFont(
                              color: Theme.of(context).canvasColor, size: 25)
                          .getFont(),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
