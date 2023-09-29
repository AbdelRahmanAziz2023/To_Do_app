import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/models/task.dart';

import '../theme.dart';
import '../widgets/button.dart';
import '../widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController taskController = Get.put(TaskController());

  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();
  int selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly', 'Yearly'];
  int selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? darkGreyClr : Colors.white,
      appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Get.isDarkMode ? Colors.white : darkGreyClr,
              size: 25,
            ),
          )),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Add Task',
                style: headingStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              InputField(
                label: 'Title',
                note: 'Enter Title here',
                controller: titleController!,
              ),
              const SizedBox(
                height: 10,
              ),
              InputField(
                label: 'Note',
                note: 'Enter Note here',
                controller: noteController!,
              ),
              const SizedBox(
                height: 10,
              ),
              InputField(
                  label: 'Date',
                  note: DateFormat.yMd().format(selectedDate),
                  widget: IconButton(
                      onPressed: () {getDate();}, icon: const Icon(Icons.date_range))),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                        label: 'Start Time',
                        note: startTime,
                        widget: IconButton(
                            onPressed: () {getTime(isSt: true);},
                            icon: const Icon(Icons.access_time))),
                  ),
                  Expanded(
                    child: InputField(
                        label: 'End Time',
                        note: endTime,
                        widget: IconButton(
                            onPressed: () {getTime(isSt: false);},
                            icon: const Icon(Icons.access_time))),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              InputField(
                  label: 'Remind',
                  note: '$selectedRemind minutes early',
                  widget: DropdownButton(
                      dropdownColor: Colors.black12,
                      items: remindList
                          .map((value) => DropdownMenuItem(
                              value: value,
                              child: Text(
                                '$value',
                                style: const TextStyle(color: Colors.white),
                              )))
                          .toList(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconSize: 32,
                      elevation: 4,
                      style: subTitleStyle,
                      underline: Container(
                        height: 0,
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          selectedRemind = newValue!;
                        });
                      })),
              const SizedBox(
                height: 10,
              ),
              InputField(
                  label: 'Repeat',
                  note: selectedRepeat,
                  widget: DropdownButton(
                      dropdownColor: Colors.black12,
                      items: repeatList
                          .map((value) => DropdownMenuItem(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(color: Colors.white),
                              )))
                          .toList(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconSize: 32,
                      elevation: 4,
                      style: subTitleStyle,
                      underline: Container(
                        height: 0,
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          selectedRepeat = newValue!;
                        });
                      })),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Color',
                        style: titlestyle,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Wrap(
                        children: List.generate(
                          3,
                          (index) => InkWell(
                            onTap: () {
                              setState(() {
                                selectedColor = index;
                              });
                            },
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: CircleAvatar(
                                  backgroundColor: index == 0
                                      ? Colors.redAccent
                                      : index == 1
                                          ? Colors.teal
                                          : Colors.amber,
                                  child: selectedColor == index
                                      ? const Icon(
                                          Icons.done,
                                          size: 25,
                                          color: Colors.white,
                                        )
                                      : null,
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                  MyButton(
                    label: 'Create Task',
                    onTap: () {
                      validateDate();
                      taskController.getTask();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }

  validateDate() {
    if (titleController.text.isNotEmpty && noteController.text.isNotEmpty) {
      addTaskToDb();
      Get.back();
    } else if (titleController.text.isEmpty || noteController.text.isEmpty) {
      Get.snackbar('Required', 'Title or Note is Empty',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.redAccent,
          icon: const Icon(
            Icons.warning,
            size: 25,
            color: Colors.redAccent,
          ));
    } else {}
  }

  addTaskToDb() async {
    Future<int> value = taskController.addTask(
        task: Task(
            title: titleController.text,
            note: noteController.text,
            isCompleted: 0,
            date: DateFormat.yMd().format(selectedDate),
            startTime: startTime,
            endTime: endTime,
            remind: selectedRemind,
            repeat: selectedRepeat,
            color: selectedColor));
    print(value);
  }

  getDate() async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (pickerDate != null) {
      setState(() {
        selectedDate = pickerDate;
      });
    }
  }

  getTime({required bool isSt}) async {
    TimeOfDay? pickerTime = await showTimePicker(
        context: context,
        initialTime: isSt
            ? TimeOfDay.fromDateTime(DateTime.now())
            : TimeOfDay.fromDateTime(
                DateTime.now().add(const Duration(minutes: 15))));
    String formatTime = pickerTime!.format(context);
    if (isSt) setState(() => startTime = formatTime);
    if (!isSt) setState(() => endTime = formatTime);
  }
}
