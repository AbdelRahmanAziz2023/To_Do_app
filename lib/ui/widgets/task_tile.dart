import 'package:flutter/material.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';

import '../../models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(
              SizeConfig.orientation == Orientation.landscape ? 4 : 20)),
      width: SizeConfig.orientation == Orientation.landscape
          ? SizeConfig.screenWidth / 2
          : SizeConfig.screenWidth,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: getClr(task.color),
        ),
        child: Row(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title!,
                    style: subheadingstyle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 20,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${task.startTime} - ${task.endTime}',
                        style: subTitleStyle,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    task.note!,
                    style: titlestyle,
                  ),
                ],
              ),
            )),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: 1,
              height: 60,
              color: Colors.grey.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task.isCompleted == 0 ? 'To do' : 'Completed',
                style: titlestyle,
              ),
            )
          ],
        ),
      ),
    );
  }

  getClr(int? color) {
    switch (color) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.teal;
      case 2:
        return Colors.amber;
      default:
        return primaryClr;
    }
  }
}
