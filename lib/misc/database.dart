List<String> getTeamsInGame({required String? gameNumber}) {
  if (gameNumber != null) {
    switch (gameNumber) {
      case '1':
        return [
          "1000",
          "1000",
          "1000",
          "1000",
          "1000",
          "1000",
        ];
      case '2':
        return [
          "2000",
          "2000",
          "2000",
          "2000",
          "2000",
          "2000",
        ];
      case '3':
        return [
          "3000",
          "3000",
          "3000",
          "3000",
          "3000",
          "3000",
        ];
      default:
        return [
          "9999",
          "9999",
          "9999",
          "9999",
          "9999",
          "9999",
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
