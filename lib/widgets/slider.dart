import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';

class OptionsSlider extends StatefulWidget {
  final double min, max;
  final double intervals;
  final String title;

  const OptionsSlider({
    Key? key,
    required this.title,
    this.min = 0,
    this.max = 1,
    this.intervals = 1,
  }) : super(key: key);

  @override
  _OptionsSliderState createState() => _OptionsSliderState();
}

class _OptionsSliderState extends State<OptionsSlider> {
  late double value;

  @override
  void initState() {
    super.initState();
    value = widget.min;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.title,
          style: AppFont(color: accentColor, size: 22.5).getFont(),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Slider(
              label: value == value.roundToDouble()
                  ? value.round().toString()
                  : value.toString(),
              value: value,
              min: widget.min,
              max: widget.max,
              divisions: (widget.max - widget.min) ~/ widget.intervals,
              onChanged: (newValue) => setState(() => value = newValue)),
        ),
      ],
    );
  }
}
