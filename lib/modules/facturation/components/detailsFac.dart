import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/modules/facturation/clients/client_model.dart';
import 'package:mobile_app/modules/facturation/clients/client_repo.dart';
import 'package:mobile_app/modules/facturation/produits/fake_repository.dart';
import 'package:mobile_app/modules/facturation/produits/product_item.dart';

class DetailsFac extends StatelessWidget {
  final ClientModel client;
  final String montant;
  final String refFac;
  final String dateFac;
  final String dateEch;
  final String dateLiv;
  final String etat;

  final produits = FakeRepo.data;
  DetailsFac(
      {super.key,
      required this.client,
      required this.montant,
      required this.refFac,
      required this.dateFac,
      required this.dateEch,
      required this.dateLiv,
      required this.etat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(145.h),
        child: Container(
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
              "Détails de facture",
              style: TextStyle(color: Colors.black87, fontSize: 55.sp),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 65.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Text(
                    'Facture client',
                    style:
                        TextStyle(fontSize: 50.sp, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    refFac,
                    style:
                        TextStyle(fontSize: 65.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Text(
                    'Client',
                    style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[800]),
                  ),
                  Text(client.nomClient),
                  Text(client.rue),
                  Text("${client.ville} ${client.etat} ${client.codePostal}"),
                  Text("${client.pays} ‒ ${client.nTVA}"),
                  SizedBox(
                    height: 70.h,
                  ),
                  Text(
                    'Date de facturation',
                    style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[700]),
                  ),
                  TextFormField(
                    readOnly: true,
                    initialValue: dateFac,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 15.w),
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  Text(
                    'Référence de paiement',
                    style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[700]),
                  ),
                  TextFormField(
                    readOnly: true,
                    initialValue: refFac,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 15.w),
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  Text(
                    'Date d\'échéance',
                    style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[700]),
                  ),
                  TextFormField(
                    readOnly: true,
                    initialValue: dateEch,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 15.w),
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                  ),

                  Text(
                    'Date de livraison',
                    style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[700]),
                  ),
                  TextFormField(
                    readOnly: true,
                    initialValue: dateLiv,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 15.w),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 50.h, top: 50.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 65.w, bottom: 20.h),
                    child: Text(
                      'Lignes de facture',
                      style: TextStyle(
                          fontSize: 55.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    height: 50.h,
                  ),
                  for (var data in produits)
                    ProductItem(
                        produit: data.produit,
                        quantite: data.quantite,
                        prixUnitaire: data.prixUnitaire,
                        prixHorsTax: data.prix_horsTax,
                        prixAvecTax: data.prix_avecTax)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
