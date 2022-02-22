import 'package:flutter/material.dart' hide ToggleButtons;
import 'package:hamosad_scouting_app/misc/data_container.dart';
import 'package:hamosad_scouting_app/widgets/widgets.dart';

class PitReport extends StatefulWidget {
  PitReport({Key? key}) : super(key: key);

  final DataContainer<String> drivingTypeData = DataContainer("");
  final DataContainer<bool> canShootUpperData = DataContainer(false);
  final DataContainer<bool> canShootLowerData = DataContainer(false);
  final DataContainer<bool> canAdjustShootAngleData = DataContainer(false);
  final DataContainer<bool> hasTurretData = DataContainer(false);
  final DataContainer<bool> canShootDynamicallyData = DataContainer(false);
  final DataContainer<bool> canShootWhileMovingData = DataContainer(false);
  final DataContainer<List<int>> whichBarCanClimbData = DataContainer([]);
  final DataContainer<String> shootingHeightData = DataContainer("");
  final DataContainer<String> weaknessesData = DataContainer("");
  final DataContainer<String> notesData = DataContainer("");

  @override
  State<PitReport> createState() => _PitReportState();
}

class _PitReportState extends State<PitReport>
    with LastPageButton, SubmitButton {
  late final DropdownMenu drivingType;
  bool drivingIsOther = false;
  late final TextEdit drivingOther;
  late final ToggleButton canShootUpper;
  late final ToggleButton canShootLower;
  late final ToggleButton canAdjustShootingAngle;
  late final ToggleButton hasTurret;
  late final ToggleButton canShootDynamically;
  late final ToggleButton canShootWhileMoving;
  late final ToggleButtons whichBarsCanClimb;
  late final DropdownMenu shootingHeight;
  late final TextEdit weaknesess;
  late final TextEdit notes;

  @override
  void initState() {
    drivingType = DropdownMenu(
        title: "Driving Type:",
        items: const ["Swerve", "Tank", "Other..."],
        onChanged: (newValue) {
          setState(() {
            if (newValue == "Other...") {
              drivingIsOther = true;
            } else {
              drivingIsOther = false;
              widget.drivingTypeData.value = newValue;
            }
          });
        });
    drivingOther = TextEdit(
      title: "Other...",
      container: widget.drivingTypeData,
      lines: 1,
      titleInLine: true,
    );
    canShootUpper = ToggleButton(
      title: "Is the robot aiming to the upper hub?",
      container: widget.canShootUpperData,
    );
    canShootLower = ToggleButton(
      title: "Is the robot aiming to the lower hub?",
      container: widget.canShootLowerData,
    );
    canAdjustShootingAngle = ToggleButton(
      title: "Can the robot adjust the angle of shooting?",
      container: widget.canAdjustShootAngleData,
    );
    hasTurret = ToggleButton(
      title: "Does the robot have a shooting turret?",
      container: widget.hasTurretData,
    );
    canShootDynamically = ToggleButton(
      title: "Can the robot shoot from more than one spot?",
      container: widget.canShootDynamicallyData,
    );
    canShootWhileMoving = ToggleButton(
      title: "Can the robot shoot while moving?",
      container: widget.canShootWhileMovingData,
    );
    whichBarsCanClimb = ToggleButtons(
        title: "Which bars can the robot climb?",
        titles: const [
          "1",
          "2",
          "3",
          "4",
        ],
        container: widget.whichBarCanClimbData);
    shootingHeight = DropdownMenu(
        title: "Shooter's Height:",
        items: const ["Low", "Mid", "High"],
        onChanged: (newValue) {
          setState(() {
            widget.shootingHeightData.value = newValue;
          });
        });
    weaknesess = TextEdit(
      title: "Weaknesses:",
      container: widget.weaknessesData,
    );
    notes = TextEdit(
      title: "Additional Notes:",
      container: widget.notesData,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: "Pit Report",
      ),
      floatingActionButton: Stack(
        children: [
          getLastPageButton(context),
          getSubmitButton(context),
        ],
      ),
      body: WidgetList(
        children: [
          drivingType,
          drivingIsOther ? drivingOther : Container(),
          canShootUpper,
          canShootLower,
          canAdjustShootingAngle,
          hasTurret,
          canShootDynamically,
          canShootWhileMoving,
          whichBarsCanClimb,
          shootingHeight,
          weaknesess,
          notes,
        ],
      ),
    );
  }
}
