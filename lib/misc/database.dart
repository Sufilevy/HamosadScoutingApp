import 'package:hamosad_scouting_app/pages/pages.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

late FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference reportsReference = database.ref("reports/testing");
DatabaseReference gamesReference = database.ref("games");
dynamic lastReport;
dynamic gameTeamsData;
dynamic gameTeams;

void getTeams() async {
  gamesReference.onValue.listen((DatabaseEvent event) {
    gameTeamsData = event.snapshot.value;
    List<Object?> games = gameTeamsData.sublist(1, gameTeamsData.length);
    gameTeams = games.asMap();
  });
}

String generateReportId() {
  var r = Random();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(6, (index) => _chars[r.nextInt(_chars.length)]).join();
}

dynamic generateReportData() {
  return {
    generateReportId(): {
      "reporterName": pages["home"].reporterNameData.value,
      "reporterTeam": pages["home"].reporterTeamData.value,
      "team": int.tryParse(pages["info"].currentTeamData.value) ??
          pages["info"].currentTeamData.value,
      "game": int.tryParse(pages["info"].gameNumberData.value) ??
          pages["info"].gameNumberData.value,
      "alliance": pages["info"].allianceData.value,
      "score": pages["summary"].totalScoreData.value,
      "focus": pages["summary"].robotFocusData.value,
      "autonomus": {
        "moved": pages["autonomus"].robotMovedData.value,
        "pickedFloor": pages["autonomus"].ballsPickedFloorData.value,
        "pickedFeeder": pages["autonomus"].ballsPickedFeederData.value,
        "shot": pages["autonomus"].ballsShotData.value,
        "lower": pages["autonomus"].lowerScoreData.value,
        "upper": pages["autonomus"].upperScoreData.value,
        "score": pages["autonomus"].lowerScoreData.value * 2 +
            pages["autonomus"].upperScoreData.value * 4,
        "notes": pages["autonomus"].notesData.value,
      },
      "teleop": {
        "canShootWhileMoving": pages["teleop"].canShootWhileMovingData.value,
        "canShootDynamically": pages["teleop"].canShootDynamicallyData.value,
        "canPickMultiple": pages["teleop"].canPickMultipleData.value,
        "pickedFloor": pages["teleop"].ballsPickedFloorData.value,
        "pickedFeeder": pages["teleop"].ballsPickedFeederData.value,
        "shot": pages["teleop"].ballsShotData.value,
        "lower": pages["teleop"].lowerScoreData.value,
        "upper": pages["teleop"].upperScoreData.value,
        "hubFocus": pages["teleop"].robotHubFocusData.value,
        "score": pages["teleop"].lowerScoreData.value +
            pages["teleop"].upperScoreData.value * 2,
        "notes": pages["teleop"].notesData.value,
      },
      "endgame": {
        "bar": pages["endgame"].barClimbedData.value.toInt(),
        "notes": pages["endgame"].notesData.value
      }
    }
  };
}

void sendReportToDatabase() async {
  await reportsReference.update(lastReport);
}
