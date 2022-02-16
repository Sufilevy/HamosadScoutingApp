import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';

class ToggleButton extends StatefulWidget {
  final String _title;

  const ToggleButton({Key? key, required String title})
      : _title = title,
        super(key: key);

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool _toggled = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.scale(
          scale: 1.5,
          alignment: Alignment.center,
          child: Checkbox(
              shape: const CircleBorder(),
              checkColor: Theme.of(context).canvasColor,
              fillColor: MaterialStateProperty.all<Color>(accentColor),
              value: _toggled,
              onChanged: (value) => setState(
                    () => _toggled = value ?? !_toggled,
                  )),
        ),
        Text(
          widget._title,
          style: AppFont(color: accentColor, size: 22.5).getFont(),
        )
      ],
    );
  }
}
