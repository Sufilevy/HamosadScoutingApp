import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/misc/data_container.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';

class TextEdit extends StatefulWidget {
  final String title;
  final double? size;
  final Color? color;
  final int? lines;
  final bool titleInLine;
  final DataContainer<String> textData;

  const TextEdit(
      {Key? key,
      required this.title,
      required DataContainer<String> container,
      this.size,
      this.lines,
      this.titleInLine = false,
      this.color})
      : textData = container,
        super(key: key);

  @override
  _TextEditState createState() => _TextEditState();
}

class _TextEditState extends State<TextEdit> {
  late final TextEditingController textController;
  final FocusNode focusNode = FocusNode();
  String? hintText;

  @override
  void initState() {
    textController = TextEditingController(text: widget.textData.value);

    hintText = widget.title;
    focusNode.addListener(() => setState(() {
          if (focusNode.hasFocus) {
            hintText = '';
          } else {
            hintText = widget.title;
          }
        }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    textController
        .addListener(() => widget.textData.value = textController.value.text);

    return Center(
      child: Column(
        children: [
          if (!widget.titleInLine)
            Text(
              widget.title,
              textDirection: currentLang['d'] as TextDirection,
              style: AppFont(size: 22.5, color: widget.color ?? accentColor)
                  .getFont(),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: widget.color ?? accentColor),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  textDirection: TextDirection.rtl,
                  decoration: widget.titleInLine
                      ? InputDecoration.collapsed(
                          hintText: hintText,
                          hintStyle: AppFont(color: widget.color ?? accentColor)
                              .getFont(),
                        )
                      : const InputDecoration(),
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.center,
                  minLines: widget.lines ?? 3,
                  maxLines: widget.lines ?? 3,
                  controller: textController,
                  focusNode: focusNode,
                  style: AppFont(size: widget.size ?? 17.5).getFont(),
                  cursorColor: widget.color ?? accentColor,
                  onChanged: (newValue) => widget.textData.value = newValue,
                  onSubmitted: (newValue) => widget.textData.value = newValue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
