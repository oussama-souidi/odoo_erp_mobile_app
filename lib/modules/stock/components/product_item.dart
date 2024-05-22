import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductItem extends StatelessWidget {
  final String produit;
  final String inventoryQuantity;
  final String reserverQuantity;

  const ProductItem(
      {super.key,
      required this.produit,
      required this.inventoryQuantity,
      required this.reserverQuantity,
});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      produit.split(']').last.trim(),
                      style: TextStyle(
                          fontSize: 50.sp, fontWeight: FontWeight.bold),
                    ),

                  ],
                ),
              ],
            ),
          ),
          /*Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 60.w),
            child: SizedBox(
              width: 200.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Quantité en stock : \n $inventoryQuantity",
                      style: TextStyle(
                          fontSize: 45.sp, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text("Quantité réservé: \n $reserverQuantity",
                      style: TextStyle(
                          fontSize: 45.sp, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          )*/
        ],
      ),
    );
  }
}
