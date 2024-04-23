import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/modules/facturation/clients/client_model.dart';
import 'package:mobile_app/modules/facturation/clients/detailsClient.dart';
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
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800]),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsClient(
                                    client: client,
                                  )));
                    },
                    child: Text(
                      "${client.nomClient}\n"
                      "${client.rue}\n"
                      "${client.ville} ${client.etat} ${client.codePostal}\n"
                      "${client.pays} ‒ ${client.nTVA}",
                      style: TextStyle(
                          fontSize: 47.sp,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  Text(
                    'Date de facturation',
                    style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[800]),
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
                        color: Colors.grey[800]),
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
                        color: Colors.grey[800]),
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
                        color: Colors.grey[800]),
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
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 30.w),
                      child: ProductItem(
                          produit: data.produit,
                          quantite: data.quantite,
                          prixUnitaire: data.prixUnitaire,
                          prixHorsTax: data.prix_horsTax,
                          prixAvecTax: data.prix_avecTax),
                    )
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 50.w),
              child: Container(
                color: Colors.red,
                width: 1080.w,
                height: 300.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    color: Colors.yellowAccent,
                    width: 540.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Montant HT: ",
                                style: TextStyle(
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[800])),
                            Text("\$ 2720.00",
                                style: TextStyle(
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[800]))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Taxe 15%: ",
                                style: TextStyle(
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[800])),
                            Text("\$ 170.00",
                                style: TextStyle(
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[800]))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Total: ",
                                style: TextStyle(
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[800])),
                            Text("\$ 2890.00",
                                style: TextStyle(
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[800]))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
