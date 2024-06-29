import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkOrderItem extends StatelessWidget {
  final String product;
  final String name;
  final String quantity;
  final String state;

  const WorkOrderItem({super.key,
    required this.product,
    required this.name,
    required this.quantity,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    Color boxColor;
    String text = state;
    Color borderColor;
    TextStyle textStyle;
    switch (text) {
      case 'ready':
        text = 'Pret';
        boxColor = const Color(0xff5ba7f6); // Light purple
        borderColor = Colors.transparent;
        textStyle = TextStyle(color: Colors.white, fontSize: 33.sp);
        break;
      case 'progress':
        text = 'En cours';
        boxColor = const Color(0xffe600ff);
        borderColor = Colors.transparent;
        textStyle = TextStyle(color: Colors.white, fontSize: 33.sp);
        break;
      case 'waiting' || 'pending':
        text = 'En attente';
        boxColor = Colors.grey.shade200;
        borderColor = Colors.transparent;
        textStyle = TextStyle(color: Colors.black, fontSize: 33.sp);
        break;
      case 'done':
        text = 'Terminé';
        boxColor = const Color(0xff4CAF50);
        borderColor = Colors.transparent;
        textStyle = TextStyle(color: Colors.white, fontSize: 33.sp);
        break;
      default:
      // Handle unexpected text by setting default styles (optional)
        boxColor = Colors.grey.shade200;
        borderColor = Colors.transparent;
        textStyle = TextStyle(color: Colors.black, fontSize: 33.sp);
    }
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 20.h),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 1),
            borderRadius: BorderRadius.circular(40.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5,
                  offset: const Offset(0, 3))
            ]),
        child: SizedBox(
          height: 320.h,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 30.h, horizontal: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name
                      ,
                      style:
                      TextStyle(fontSize: 45.sp, fontWeight: FontWeight.bold),
                    ),

                  ],
                ),
                Row(
                  children: [
                    Text(
                      product,
                      style: TextStyle(
                          fontSize: 44.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[700]),
                    ),
                  ],
                ),
                SizedBox(width: 15.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$quantity Unité(s)',
                      style: TextStyle(
                          fontSize: 44.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[700]),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: boxColor,
                          border: Border.all(color: borderColor),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w,
                            vertical: 3.h),
                        child: FittedBox(
                          child: Text(text,
                              style:
                              textStyle),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );

  }
}
