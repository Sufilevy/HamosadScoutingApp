import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';

class DropdownMenu extends StatefulWidget {
  final String title;
  final List<String> items;
  final void Function(String) onChanged;

  const DropdownMenu(
      {Key? key,
      required this.title,
      required this.items,
      required this.onChanged})
      : super(key: key);

  @override
  _DropdownMenuState createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  String? currentValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(widget.title,
              style: AppFont(color: accentColor, size: 22.5).getFont()),
        ),
        DropdownButton<String>(
          value: currentValue,
          style: AppFont(color: accentColor, size: 22.5).getFont(),
          alignment: Alignment.center,
          onChanged: (String? newValue) {
            setState(() {
              currentValue = newValue;
              widget.onChanged(newValue!);
            });
          },
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
