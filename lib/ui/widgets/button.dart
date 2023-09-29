import 'package:flutter/material.dart';
import 'package:todo/ui/theme.dart';

class MyButton extends StatelessWidget {
   MyButton({Key? key,required this.label, required this.onTap}) : super(key: key);
  final label;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Container(
        height:60,
        width:140,
        alignment:Alignment.center,
        decoration:BoxDecoration(
          color:primaryClr,
          borderRadius: BorderRadius.circular(15),
        ),
        child:Text(
          label,style: const TextStyle(
          color:Colors.white,
          fontSize:25
        ),
        ),
      ),
    );
  }
}
