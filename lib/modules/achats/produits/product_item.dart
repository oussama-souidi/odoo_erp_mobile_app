import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ProductItem extends StatelessWidget {
  final String produit;
  final double quantite;
  final double prixUnitaire;
  final double prixHorsTax;
  final double prixAvecTax;

  const ProductItem({super.key, required this.produit, required this.quantite, required this.prixUnitaire, required this.prixHorsTax, required this.prixAvecTax});


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
            padding: EdgeInsets.symmetric(
                vertical: 50.h, horizontal: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment:
              MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      produit,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Quantite : $quantite",
                      style: TextStyle(
                          fontSize: 48.sp,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[700]),
                    ),
                  ],
                ),
                SizedBox(height: 30.h,),
                Text(
                  "Prix unitaire : $prixUnitaire",
                  style: TextStyle(
                      fontSize: 48.sp,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 20.h, horizontal: 60.w),
            child: SizedBox(
              width: 200.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Text("HT : \n $prixHorsTax",
                      style: TextStyle(
                          fontSize: 45.sp,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text("TTC: \n $prixAvecTax",
                      style: TextStyle(
                          fontSize: 45.sp,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
