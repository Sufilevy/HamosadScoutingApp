import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/misc/string_container.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';

class TextEdit extends StatefulWidget {
  final String title;
  final StringContainer? container;

  const TextEdit({Key? key, required this.title, this.container})
      : super(key: key);

  @override
  _TextEditState createState() => _TextEditState();
}

class _TextEditState extends State<TextEdit> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.container != null) {
      _textController.addListener(
          () => widget.container!.value = _textController.value.text);
    }
    return Column(
      children: [
        Text(
          widget.title,
          style: AppFont(color: accentColor, size: 22.5).getFont(),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
          child: DecoratedBox(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: accentColor)),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: EditableText(
                  textAlign: TextAlign.center,
                  minLines: 3,
                  maxLines: 3,
                  controller: _textController,
                  focusNode: FocusNode(),
                  style: AppFont(color: accentColor, size: 17.5).getFont(),
                  cursorColor: accentColor,
                  backgroundCursorColor: accentColor),
            ),
          ),
        ),
      ],
    );
  }
}
