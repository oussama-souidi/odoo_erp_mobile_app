import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class appBar extends StatelessWidget {
  final String title;
  const appBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.black87, fontSize: 55.sp),
        ),
      ),
    );
  }
}