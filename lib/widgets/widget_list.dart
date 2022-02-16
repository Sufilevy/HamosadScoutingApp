import 'package:flutter/material.dart';

class WidgetList extends StatelessWidget {
  final List<Widget> _widgets;

  WidgetList({Key? key, required List<Widget> children})
      : _widgets = List<Widget>.generate(
            children.length * 2,
            (i) => ((i + 1) % 2 == 0)
                ? children[i ~/ 2]
                : const SizedBox(
                    height: 20,
                  )),
        super(key: key) {
    _widgets.add(const SizedBox(
      height: 200,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center, children: _widgets));
  }
}
