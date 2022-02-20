import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';
import 'package:hamosad_scouting_app/widgets/widgets.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Stack(
          children: [
            Center(
              child: Text(
                "History",
                style: AppFont(
                  size: 23,
                ).getFont(),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: GestureDetector(
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: accentColor,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    SystemSound.play(SystemSoundType.click);
                  },
                ),
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: reports.isNotEmpty
            ? WidgetList(
                children: List.generate(
                  reports.length,
                  (index) => Text(
                    "${index + 1}: ${reports[index]}",
                    style: AppFont(color: Colors.grey.shade700, size: 25)
                        .getFont(),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(40),
                child: Text(
                  "There are no reports in the history, create a new report",
                  textAlign: TextAlign.center,
                  style:
                      AppFont(color: Colors.grey.shade700, size: 25).getFont(),
                ),
              ),
      ),
    );
  }
}
