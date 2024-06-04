import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../components/appBar.dart';

class detailsPage extends StatelessWidget {
  final String nomProduit;
  final String refProduit;
  final String prixVente;
  final String cout;
  final String quantite;

  const detailsPage(
      {super.key,
      required this.nomProduit,
      required this.refProduit,
      required this.prixVente,
      required this.cout,
      required this.quantite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff7f7f7),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(145.h),
          child: const appBar(
            title: "Détails de produit",
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 65.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    Text(
                      'Nom du produit',
                      style: TextStyle(
                          fontSize: 44.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700]),
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: nomProduit,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15.w),
                      ),
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    Text(
                      'Référence interne',
                      style: TextStyle(
                          fontSize: 44.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700]),
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: refProduit.toString(),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15.w),
                      ),
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    Text(
                      'Prix de vente',
                      style: TextStyle(
                          fontSize: 44.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700]),
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: prixVente,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15.w),
                      ),
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    Text(
                      'Coût',
                      style: TextStyle(
                          fontSize: 44.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700]),
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: cout,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15.w),
                      ),
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    Text(
                      'Quantité en stock',
                      style: TextStyle(
                          fontSize: 44.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700]),
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: quantite,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15.w),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ));
  }
}
