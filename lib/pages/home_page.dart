import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';
import 'package:hamosad_scouting_app/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: "",
        buttons: [
          GestureDetector(
            child: Icon(
              Icons.info_outline_rounded,
              color: Colors.grey.shade600,
              size: 35,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutPage()));
              SystemSound.play(SystemSoundType.click);
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create a\nnew report",
              textAlign: TextAlign.center,
              style: AppFont(size: 45, color: Colors.grey.shade700).getFont(),
            ),
            const SizedBox(
              height: 20,
            ),
            IconButton(
              icon: const Icon(Icons.add_box_outlined),
              tooltip: "Create a new report",
              iconSize: 100,
              color: Colors.grey.shade700,
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GeneralInformationPage())),
            ),
          ],
        ),
      ),
    );
  }
}
