import 'package:hamosad_scouting_app/pages/pages.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

late FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference gameReportsReference = database.ref("pregional/reports");
DatabaseReference pitReportsReference = database.ref("pregional/pit");
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

dynamic getDatetime() {
  DateTime now = DateTime.now();

  return {
    "day": now.day.toString(),
    "month": now.month.toString(),
    "year": now.year.toString(),
    "time": now.hour.toString() + ":" + now.minute.toString(),
  };
}

dynamic generateGameReportData(
    {String? id, String? reporterName, String? reporterTeam}) {
  return {
    id ?? generateReportId(): {
      "reporterName": reporterName ?? pages["home"].reporterNameData.value,
      "reporterTeam": reporterTeam ?? pages["home"].reporterTeamData.value,
      "team": int.tryParse(pages["info"].currentTeamData.value) ??
          pages["info"].currentTeamData.value,
      "datetime": getDatetime(),
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
      },
    }
  };
}

dynamic generatePitReportData(
    {String? id, String? reporterName, String? reporterTeam}) {
  return {
    id ?? generateReportId(): {
      "reporterName": reporterName ?? pages["home"].reporterNameData.value,
      "reporterTeam": reporterTeam ?? pages["home"].reporterTeamData.value,
      "team": int.tryParse(pages["pit_info"].currentTeamData.value) ??
          pages["info"].currentTeamData.value,
      "datetime": getDatetime(),
      "drivingType": pages["pit"].drivingTypeData.value,
      "canShootUpper": pages["pit"].canShootUpperData.value,
      "canShootLower": pages["pit"].canShootLowerData.value,
      "canAdjustShootAngle": pages["pit"].canAdjustShootAngleData.value,
      "hasTurret": pages["pit"].hasTurretData.value,
      "canShootDynamically": pages["pit"].canShootDynamicallyData.value,
      "canShootWhileMoving": pages["pit"].canShootWhileMovingData.value,
      "whichBarCanClimb": pages["pit"].whichBarCanClimbData.value,
      "shootingHeight": pages["pit"].shootingHeightData.value,
      "weaknesses": pages["pit"].weaknessesData.value,
      "notes": pages["pit"].notesData.value,
    }
  };
}

void sendReportToDatabase() async {
  if (reportType == ReportType.game) {
    await gameReportsReference.update(lastReport);
  } else {
    await pitReportsReference.update(lastReport);
  }
}
