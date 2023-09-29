import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/services/notification_services.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/pages/add_task_page.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/task_tile.dart';

import '../../controllers/task_controller.dart';
import '../../models/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskController taskController = Get.put(TaskController());
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskController.getTask();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Get.isDarkMode ? darkGreyClr : Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            ThemeServices().switchTheme();
            NotifyHelper().displayNotification(
              title: 'Hello',
              body: 'Theme mode Change',
            );
          },
          icon: Icon(Get.isDarkMode ? Icons.sunny : Icons.nights_stay),
          color: Get.isDarkMode ? Colors.white : darkGreyClr,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          addTaskBar(),
          const SizedBox(
            height: 5,
          ),
          addDateBar(),
          const SizedBox(
            height: 5,
          ),
          showTasks(),
        ],
      ),
    );
  }

  addTaskBar() {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subheadingstyle,
              ),
              Text(
                'Today',
                style: headingStyle,
              )
            ],
          ),
          MyButton(
              label: '+ Add Task',
              onTap: () async {
                Get.to(AddTaskPage());
                await taskController.getTask();
              })
        ],
      ),
    );
  }

  addDateBar() {
    return Container(
      margin: const EdgeInsets.all(5),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        selectedTextColor: Colors.white,
        selectionColor: primaryClr,
        dateTextStyle: titlestyle,
        dayTextStyle: titlestyle,
        monthTextStyle: titlestyle,
        initialSelectedDate: selectedDate,
        onDateChange: (newDate) {
          setState(() {
            selectedDate = newDate;
          });
        },
      ),
    );
  }

  BSheet(BuildContext context, Task task) {
    Get.bottomSheet(SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 5),
        width: SizeConfig.screenWidth,
        height: SizeConfig.orientation == Orientation.landscape
            ? task.isCompleted == 1
                ? SizeConfig.screenHeight * 0.6
                : SizeConfig.screenHeight * 0.8
            : task.isCompleted == 1
                ? SizeConfig.screenHeight * 0.3
                : SizeConfig.screenHeight * 0.4,
        color: Get.isDarkMode ? darkHeaderClr : Colors.white,
        child: Column(
          children: [
            Flexible(
                child: Container(
              height: 10,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
            )),
            SizedBox(
              height: 10,
            ),
            task.isCompleted == 1
                ? Container()
                : ButtonSheet(
                    label: 'Task Completed',
                    onTap: () {
                      taskController.markAsCompletedTask(task);
                      Get.back();
                    },
                    Clr: primaryClr),
            ButtonSheet(
                label: 'Task Deleted',
                onTap: () {
                  taskController.deleteTask(task);
                  Get.back();
                },
                Clr: primaryClr),
            Divider(
              indent: 30,
              endIndent: 30,
              height: 5,
              thickness: 2,
              color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
            ),
            ButtonSheet(
                label: 'Cancel',
                onTap: () {
                  Get.back();
                },
                Clr: primaryClr),
          ],
        ),
      ),
    ));
  }

  ButtonSheet(
      {required String label,
      required Function() onTap,
      required Color Clr,
      bool isClose = false}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 70,
        width: SizeConfig.screenWidth * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 2,
            color: isClose
                ? Get.isDarkMode
                    ? Colors.grey[300]!
                    : Colors.grey[300]!
                : Clr,
          ),
          color: isClose ? Colors.transparent : Clr,
        ),
        child: Text(
          label,
          style:
              isClose ? titlestyle : titlestyle.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  showTasks() {
    return Expanded(child: Obx(() {
      if (taskController.taskList.isEmpty) {
        return Stack(alignment: Alignment.center, children: [
          AnimatedPositioned(
            duration: const Duration(seconds: 2),
            child: SingleChildScrollView(
              child: Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  SvgPicture.asset(
                    'images/task.svg',
                    height: 100,
                    color: primaryClr.withOpacity(0.5),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "You don't have any task yet",
                      style: titlestyle,
                    ),
                  )
                ],
              ),
            ),
          ),
        ]);
      } else {
        return ListView.builder(
            scrollDirection: SizeConfig.orientation == Orientation.landscape
                ? Axis.horizontal
                : Axis.vertical,
            itemCount: taskController.taskList.length,
            itemBuilder: (BuildContext context, int index) {
              var task = taskController.taskList[index];
              var hour = task.startTime.toString().split(':')[0];
              var minutes = task.startTime.toString().split(':')[1];
              // NotifyHelper().scheduledNotification(
              //     int.parse(hour), int.parse(minutes), task);
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(seconds: 2),
                child: SlideAnimation(
                  horizontalOffset: 300,
                  child: FadeInAnimation(
                    child: InkWell(
                        onTap: () {
                          BSheet(context, task);
                        },
                        child: TaskTile(task: task)),
                  ),
                ),
              );
            });
      }
    }));
  }
}
