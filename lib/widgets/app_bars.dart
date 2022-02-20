import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';

class PageAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  final bool automaticallyImplyLeading;
  late final Row actionButtons;
  final Widget? leading;
  final bool showLogo;

  PageAppBar(
      {Key? key,
      required this.title,
      this.automaticallyImplyLeading = false,
      buttons = const <Widget>[],
      this.leading,
      this.showLogo = false})
      : preferredSize = const Size.fromHeight(56),
        super(key: key) {
    if (buttons != null) {
      if (buttons != null && buttons!.isNotEmpty) {
        actionButtons = Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: List.generate(
            buttons.length,
            (index) => Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: buttons[index],
              ),
            ),
          ),
        );
      } else {
        actionButtons = Row();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Stack(
        children: [
          showLogo
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: ImageIcon(
                      const AssetImage(
                          "assets/png/hamosad_logo_dark_transperent.png"),
                      size: 70,
                      color: accentColor),
                )
              : Container(),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 20, 20),
              child: Text(
                title,
                style: AppFont(
                  size: 23,
                ).getFont(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: actionButtons,
          ),
        ],
      ),
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading,
    );
  }
}
