import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/modules/ventes/produits/fake_repository.dart';

import '../../../components/appBar.dart';
import '../produits/product_item.dart';


class detailsPage extends StatelessWidget {
  final String fournisseur;
  final String montant;
  final String id;
  final String date;
  final String etat;

  detailsPage(
      {super.key,
      required this.fournisseur,
      required this.montant,
      required this.id,
      required this.date,
      required this.etat});
  final _data = FakeRepo.data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(145.h),
          child: const appBar(title: "Détails de commande",),
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
                      'Fournisseur',
                      style: TextStyle(
                          fontSize: 44.sp,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[700]),
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue:fournisseur,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15.w),
                      ),
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    Text(
                      'Montant',
                      style: TextStyle(
                          fontSize: 44.sp,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[700]),
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue:montant,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15.w),
                      ),
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    Text(
                      'Code de commande',
                      style: TextStyle(
                          fontSize: 44.sp,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[700]),
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue:id,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15.w),
                      ),
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    Text(
                      'Date de commande',
                      style: TextStyle(
                          fontSize: 44.sp,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[700]),
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue:date,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15.w),
                      ),
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    Text(
                      'Etat de commande',
                      style: TextStyle(
                          fontSize: 44.sp,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[700]),
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue:etat,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15.w),
                      ),
                    ),
                    SizedBox(
                      height: 90.h,
                    ),

                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 65.w),
                    child: Text(
                      'Produits',
                      style: TextStyle(
                          fontSize: 55.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    height: 20.h,
                  ),
                  for (var data in _data)
                    ProductItem(
                        produit: data.produit,
                        quantite: data.quantite,
                        prixUnitaire: data.prixUnitaire,
                        prixHorsTax: data.prix_horsTax,
                        prixAvecTax: data.prix_avecTax)
                ],
              ),
            ],
          ),
        ));
  }
}
