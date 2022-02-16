import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';

class PageAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String _title;
  final bool _automaticallyImplyLeading;
  final List<Widget>? _buttons;

  PageAppBar(
      {Key? key,
      required String title,
      bool automaticallyImplyLeading = false,
      List<Widget>? buttons})
      : _title = title,
        preferredSize = const Size.fromHeight(56.0),
        _automaticallyImplyLeading = automaticallyImplyLeading,
        _buttons = [],
        super(key: key) {
    if (buttons != null) {
      for (final button in buttons) {
        _buttons?.add(Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: button,
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Stack(children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: ImageIcon(
              const AssetImage("assets/png/hamosad_logo_dark_transperent.png"),
              size: 70.0,
              color: accentColor),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 20, 20),
            child: Text(
              _title,
              style: AppFont(
                size: 23.0,
                color: accentColor,
              ).getFont(),
            ),
          ),
        ),
        ...?_buttons,
      ]),
      automaticallyImplyLeading: _automaticallyImplyLeading,
    );
  }
}
