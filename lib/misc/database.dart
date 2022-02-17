import 'package:hamosad_scouting_app/pages/pages.dart';

List<String> getTeamsInGame({required String? gameNumber}) {
  if (gameNumber != null) {
    switch (gameNumber) {
      case '1':
        return [
          "6740",
          "2096",
          "3075",
          "7067",
          "7845",
          "1942",
        ];
      case '2':
        return [
          "5951",
          "7112",
          "1574",
          "3211",
          "8223",
          "5635",
        ];
      case '3':
        return [
          "1577",
          "1943",
          "1937",
          "2630",
          "1657",
          "4744",
        ];
      case '4':
        return [
          "4416",
          "5715",
          "4590",
          "7039",
          "1690",
          "2212",
        ];
      case '5':
        return [
          "3835",
          "5715",
          "4590",
          "7039",
          "1690",
          "2212",
        ];
      case '6':
        return [
          "5951",
          "7112",
          "1574",
          "3211",
          "8223",
          "5635",
        ];
      case '7':
        return [
          "4416",
          "5715",
          "4590",
          "7039",
          "1690",
          "2212",
        ];
      case '8':
        return [
          "5951",
          "7112",
          "1574",
          "3211",
          "8223",
          "5635",
        ];
      default:
        return [
          "0000",
          "0000",
          "0000",
          "0000",
          "0000",
          "0000",
        ];
    }
  } else {
    return [
      "0000",
      "0000",
      "0000",
      "0000",
      "0000",
      "0000",
    ];
  }
}

dynamic generateReportData() {
  return {
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
      "notes": pages["autonomus"].notesData.value,
    },
    "teleop": {
      "shootsWhileMoving": pages["teleop"].canShootWhileMovingData.value,
      "pickedFloor": pages["teleop"].ballsPickedFloorData.value,
      "pickedFeeder": pages["teleop"].ballsPickedFeederData.value,
      "shot": pages["teleop"].ballsShotData.value,
      "lower": pages["teleop"].lowerScoreData.value,
      "upper": pages["teleop"].upperScoreData.value,
      "notes": pages["teleop"].notesData.value,
    },
    "endgame": {
      "bar": pages["endgame"].barClimbedData.value.toInt(),
      "notes": pages["endgame"].notesData.value
    }
  };
}
