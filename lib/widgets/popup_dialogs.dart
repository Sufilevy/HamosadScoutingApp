import 'package:hamosad_scouting_app/pages/pages.dart';
import 'package:flutter/material.dart';

class PopupDialogButton {
  final String _text;
  final void Function() _onPressed;

  PopupDialogButton({required String text, required void Function() onPressed})
      : _text = text,
        _onPressed = onPressed;
}

class PopupDialog extends StatelessWidget {
  final String _title;
  final String _body;
  final List<Widget> _buttons;

  PopupDialog(BuildContext context,
      {Key? key,
      required String title,
      required String body,
      required List<PopupDialogButton> buttons})
      : _title = title,
        _body = body,
        _buttons = [],
        super(key: key) {
    for (var button in buttons) {
      _buttons.add(
        Expanded(
          flex: 1,
          child: Container(),
        ),
      );
      _buttons.add(
        Expanded(
          flex: 4,
          child: TextButton(
            onPressed: button._onPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(accentColor),
            ),
            child: Text(
              button._text,
              textDirection: currentLang['d'] as TextDirection,
              style: AppFont(color: Theme.of(context).canvasColor, size: 20)
                  .getFont(),
            ),
          ),
        ),
      );
      _buttons.add(
        Expanded(
          flex: 1,
          child: Container(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        _title,
        textAlign: TextAlign.center,
        style: AppFont(size: 27.5).getFont(),
      ),
      content: Text(
        _body,
        textDirection: currentLang['d'] as TextDirection,
        textAlign: TextAlign.center,
        style: AppFont(size: 22.5).getFont(),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buttons,
        )
      ],
    );
  }
}
