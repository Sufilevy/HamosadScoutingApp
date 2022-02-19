import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/misc/data_container.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';

class ToggleButton extends StatefulWidget {
  final String title;
  final DataContainer<bool> toggledData;
  final void Function(bool)? onChanged;

  const ToggleButton(
      {Key? key,
      required this.title,
      required DataContainer<bool> container,
      this.onChanged})
      : toggledData = container,
        super(key: key);

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1.5,
            alignment: Alignment.center,
            child: Checkbox(
              shape: const CircleBorder(),
              checkColor: Theme.of(context).canvasColor,
              fillColor: MaterialStateProperty.all<Color>(accentColor),
              value: widget.toggledData.value,
              onChanged: (value) => setState(
                () {
                  widget.toggledData.value = value ?? !widget.toggledData.value;
                  if (widget.onChanged != null) {
                    widget.onChanged!(widget.toggledData.value);
                  }
                },
              ),
            ),
          ),
          Flexible(
            child: TextButton(
              child: Text(widget.title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: AppFont(size: 22.5).getFont()),
              onPressed: () => setState(
                () {
                  widget.toggledData.value = !widget.toggledData.value;
                  if (widget.onChanged != null) {
                    widget.onChanged!(widget.toggledData.value);
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
