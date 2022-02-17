import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/misc/data_container.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';

class TextEdit extends StatefulWidget {
  final String title;
  final double? size;
  final int? lines;
  final DataContainer<String> textData;

  const TextEdit(
      {Key? key,
      required this.title,
      required DataContainer<String> container,
      this.size,
      this.lines})
      : textData = container,
        super(key: key);

  @override
  _TextEditState createState() => _TextEditState();
}

class _TextEditState extends State<TextEdit> {
  late final TextEditingController textController;

  @override
  void initState() {
    textController = TextEditingController(text: widget.textData.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    textController
        .addListener(() => widget.textData.value = textController.value.text);

    return Column(
      children: [
        Text(
          widget.title,
          style: AppFont(size: 22.5).getFont(),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(color: accentColor),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: EditableText(
                  textAlign: TextAlign.center,
                  minLines: widget.lines ?? 3,
                  maxLines: widget.lines ?? 3,
                  controller: textController,
                  focusNode: FocusNode(),
                  style: AppFont(size: widget.size ?? 17.5).getFont(),
                  cursorColor: accentColor,
                  backgroundCursorColor: accentColor),
            ),
          ),
        ),
      ],
    );
  }
}
