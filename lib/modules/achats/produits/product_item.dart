import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ProductItem extends StatelessWidget {
  final String produit;
  final String quantite;
  final String prixUnitaire;
  final String prix_horsTax;
  final String prix_avecTax;

  const ProductItem({super.key, required this.produit, required this.quantite, required this.prixUnitaire, required this.prix_horsTax, required this.prix_avecTax});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 1),
          borderRadius: BorderRadius.circular(20),
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
                vertical: 8.h, horizontal: 30.w),
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
                  Text("HT : \n $prix_horsTax",
                      style: TextStyle(
                          fontSize: 45.sp,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text("TTC: \n $prix_avecTax",
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
