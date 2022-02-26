import 'package:hamosad_scouting_app/pages/pages.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference districtReference = database.ref("district");
late DatabaseReference gameReportsReference;
late DatabaseReference pitReportsReference;
DatabaseReference gamesReference = database.ref("games");
dynamic lastReport;
dynamic gameTeamsData;
late dynamic gameTeams;
late int numberOfGames;

void initData() {
  districtReference.onValue.listen((DatabaseEvent event) {
    String? district = event.snapshot.value.toString();
    gameReportsReference = database.ref("$district/reports");
    pitReportsReference = database.ref("$district/pit");
  });
}

void getTeams() {
  gamesReference.onValue.listen((DatabaseEvent event) {
    gameTeamsData = event.snapshot.value;
    gameTeams = gameTeamsData.asMap();
    numberOfGames = gameTeams.length;
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
    "timeValue": now.hour * 60 + now.minute,
  };
}

dynamic generateGameReportData(
    {String? id, String? reporterName, String? reporterTeam}) {
  return {
    id ?? generateReportId(): {
      "info": {
        "reporterName": reporterName ?? pages["home"].reporterNameData.value,
        "reporterTeamNumber":
            reporterTeam ?? pages["home"].reporterTeamData.value,
        "teamNumber": int.tryParse(pages["info"].currentTeamData.value) ??
            pages["info"].currentTeamData.value,
        "datetime": getDatetime(),
        "gameNumber": int.tryParse(pages["info"].gameNumberData.value) ??
            pages["info"].gameNumberData.value,
        "alliance": pages["info"].allianceData.value,
      },
      "summary": {
        "totalScore": pages["summary"].totalScoreData.value,
        "robotFocus": pages["summary"].robotFocusData.value,
        "hubLower": pages["autonomus"].lowerScoreData.value +
            pages["teleop"].lowerScoreData.value,
        "hubUpper": pages["autonomus"].upperScoreData.value +
            pages["teleop"].upperScoreData.value,
        "hubMissed": pages["autonomus"].ballsMissedData.value +
            pages["teleop"].ballsMissedData.value,
        "ballsShot": pages["autonomus"].ballsMissedData.value +
            pages["autonomus"].lowerScoreData.value +
            pages["autonomus"].upperScoreData.value +
            pages["teleop"].ballsMissedData.value +
            pages["teleop"].lowerScoreData.value +
            pages["teleop"].upperScoreData.value,
      },
      "stageAutonomus": {
        "moved": pages["autonomus"].robotMovedData.value,
        "pickedFloor": pages["autonomus"].ballsPickedFloorData.value,
        "pickedFeeder": pages["autonomus"].ballsPickedFeederData.value,
        "hubMissed": pages["autonomus"].ballsMissedData.value,
        "hubLower": pages["autonomus"].lowerScoreData.value,
        "hubUpper": pages["autonomus"].upperScoreData.value,
        "totalScore": pages["autonomus"].lowerScoreData.value * 2 +
            pages["autonomus"].upperScoreData.value * 4,
        "ballsShot": pages["autonomus"].ballsMissedData.value +
            pages["autonomus"].lowerScoreData.value +
            pages["autonomus"].upperScoreData.value,
        "notes": pages["autonomus"].notesData.value,
      },
      "stageTeleop": {
        "canShootWhileMoving": pages["teleop"].canShootWhileMovingData.value,
        "canShootDynamically": pages["teleop"].canShootDynamicallyData.value,
        "canPickMultiple": pages["teleop"].canPickMultipleData.value,
        "pickedFloor": pages["teleop"].ballsPickedFloorData.value,
        "pickedFeeder": pages["teleop"].ballsPickedFeederData.value,
        "hubMissed": pages["teleop"].ballsMissedData.value,
        "hubLower": pages["teleop"].lowerScoreData.value,
        "hubUpper": pages["teleop"].upperScoreData.value,
        "ballsShot": pages["teleop"].ballsMissedData.value +
            pages["teleop"].lowerScoreData.value +
            pages["teleop"].upperScoreData.value,
        "totalScore": pages["teleop"].lowerScoreData.value +
            pages["teleop"].upperScoreData.value * 2,
        "notes": pages["teleop"].notesData.value,
      },
      "stageEndgame": {
        "barClimbed": pages["endgame"].barClimbedData.value.toInt(),
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
  if (lastReportType == ReportType.game) {
    await gameReportsReference.update(lastReport);
  } else {
    await pitReportsReference.update(lastReport);
  }
}
