import 'package:flutter/material.dart' hide ToggleButtons;
import 'package:hamosad_scouting_app/misc/data_container.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';
import 'package:hamosad_scouting_app/widgets/widgets.dart';

class PitReport extends StatefulWidget {
  PitReport({Key? key}) : super(key: key);

  final DataContainer<String> drivingTypeData = DataContainer(langEntries['tank'][currentLang['i']]);
  final DataContainer<bool> canShootUpperData = DataContainer(false);
  final DataContainer<bool> canShootLowerData = DataContainer(false);
  final DataContainer<bool> canAdjustShootAngleData = DataContainer(false);
  final DataContainer<bool> hasTurretData = DataContainer(false);
  final DataContainer<bool> canShootWhileMovingData = DataContainer(false);
  final DataContainer<bool> cantShootDynamicallyData = DataContainer(false);
  final DataContainer<String> anchorPointData = DataContainer("");
  final DataContainer<List<int>> whichBarCanClimbData = DataContainer([]);
  final DataContainer<String> shootingHeightData = DataContainer(langEntries['low'][currentLang['i']]);
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
  late final ToggleButton cantShootDynamically;
  late final TextEdit anchorPoint;
  late final ToggleButton canShootWhileMoving;
  late final ToggleButtons whichBarsCanClimb;
  late final DropdownMenu shootingHeight;
  late final TextEdit weaknesess;
  late final TextEdit notes;

  @override
  void initState() {
    drivingType = DropdownMenu(
      title: langEntries['driving_type'][currentLang['i']],
      items: [
        langEntries['swerve'][currentLang['i']],
        langEntries['tank'][currentLang['i']],
        langEntries['other'][currentLang['i']],
      ],
      value: widget.drivingTypeData.value,
      onChanged: (newValue) {
        setState(
          () {
            if (newValue == langEntries['other'][currentLang['i']]) {
              drivingIsOther = true;
            } else {
              drivingIsOther = false;
              widget.drivingTypeData.value = newValue;
            }
          },
        );
      },
    );
    drivingOther = TextEdit(
      title: langEntries['other'][currentLang['i']],
      container: widget.drivingTypeData,
      lines: 1,
      titleInLine: true,
    );
    canShootUpper = ToggleButton(
      title: langEntries['aiming_upper'][currentLang['i']],
      container: widget.canShootUpperData,
    );
    canShootLower = ToggleButton(
      title: langEntries['aiming_lower'][currentLang['i']],
      container: widget.canShootLowerData,
    );
    canAdjustShootingAngle = ToggleButton(
      title: langEntries['adjust_angle'][currentLang['i']],
      container: widget.canAdjustShootAngleData,
    );
    hasTurret = ToggleButton(
      title: langEntries['has_turret'][currentLang['i']],
      container: widget.hasTurretData,
    );
    cantShootDynamically = ToggleButton(
      title: langEntries['cant_shoot_dynamically'][currentLang['i']],
      container: widget.cantShootDynamicallyData,
      onChanged: (newValue) {
        setState(
          () {
            widget.cantShootDynamicallyData.value = newValue;
          },
        );
      },
    );
    anchorPoint = TextEdit(
      title: langEntries['anchor_point'][currentLang['i']],
      container: widget.anchorPointData,
      lines: 1,
      titleInLine: true,
    );
    canShootWhileMoving = ToggleButton(
      title: langEntries['shoot_while_moving'][currentLang['i']],
      container: widget.canShootWhileMovingData,
    );

    whichBarsCanClimb = ToggleButtons(
        title: langEntries['bars_can_climb'][currentLang['i']],
        titles: const [
          "1",
          "2",
          "3",
          "4",
        ],
        container: widget.whichBarCanClimbData);
    shootingHeight = DropdownMenu(
        value: widget.shootingHeightData.value,
        title: langEntries['shooter_height'][currentLang['i']],
        items: [
          langEntries['low'][currentLang['i']],
          langEntries['mid'][currentLang['i']],
          langEntries['high'][currentLang['i']],
        ],
        onChanged: (newValue) {
          setState(() {
            widget.shootingHeightData.value = newValue;
          });
        });
    weaknesess = TextEdit(
      title: langEntries['weaknesses'][currentLang['i']],
      container: widget.weaknessesData,
    );
    notes = TextEdit(
      title: langEntries['additional_notes'][currentLang['i']],
      container: widget.notesData,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: langEntries['pit'][currentLang['i']],
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
          cantShootDynamically,
          widget.cantShootDynamicallyData.value ? anchorPoint : null,
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
