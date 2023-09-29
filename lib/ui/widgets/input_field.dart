import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/size_config.dart';

import '../theme.dart';

class InputField extends StatelessWidget {
  InputField(
      {Key? key, required this.label, required this.note, this.controller, this.widget})
      : super(key: key);
  final String label;
  final String note;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: titlestyle),
          Container(
            //margin: const EdgeInsets.only(left: 0),
            padding: const EdgeInsets.only(left:10),
            width: SizeConfig.screenWidth,
            height: 52,
            decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey)),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    autofocus: false,
                    readOnly:widget!=null?true:false,
                    style:subTitleStyle,
                    cursorColor:Get.isDarkMode?Colors.white:Colors.black,
                    decoration: InputDecoration(
                      hintText: note,
                      hintStyle: subTitleStyle,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: primaryClr,width:0),),
                      focusedBorder:UnderlineInputBorder(
                          borderSide: BorderSide(color: primaryClr)),
                    ),
                  ),
                ),
                widget ?? Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
