import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/modules/facturation/clients/client_model.dart';
import 'package:mobile_app/modules/ventes/produits/fake_repository.dart';

import '../../../components/appBar.dart';
import '../../facturation/clients/detailsClient.dart';
import '../produits/product_item.dart';


class detailsPage extends StatelessWidget {
  final ClientModel client;
  final String montant;
  final String id;
  final String date;
  final String etat;

  detailsPage(
      {super.key,
      required this.client,
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
          child: appBar(title: id,),
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
                      'Client',
                      style: TextStyle(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    SizedBox(height: 20.h,),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) => DetailsClient(client: client,)));
                      },
                      child: Text(
                        "${client.nomClient}\n"
                            "${client.rue}\n"
                            "${client.ville} ${client.etat} ${client.codePostal}\n"
                            "${client.pays} ‒ ${client.nTVA}",
                        style: TextStyle(fontSize: 47.sp, color: Colors.grey[700], fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    Text(
                      'Date de commande',
                      style: TextStyle(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
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
                          fontSize: 50.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
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
                      'Lignes de commande',
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
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
                      child: ProductItem(
                          produit: data.produit,
                          quantite: data.quantite,
                          prixUnitaire: data.prixUnitaire,
                          prixHorsTax: data.prix_horsTax,
                          prixAvecTax: data.prix_avecTax),
                    )
                ],
              ),
              const Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.h),
                child: SizedBox(
                  height: 300.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle, // Add space between rows
                      children: [
                        TableRow(
                          children: [
                            TableCell(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('Montant HT: ',
                                        style: TextStyle(
                                            fontSize: 48.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[800])))),
                            TableCell(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('\$ 2720.00',
                                        style: TextStyle(
                                            fontSize: 48.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[800])))),
                          ],
                        ),
                        TableRow(
                            children: [
                              SizedBox(height: 20.h,),
                              SizedBox(height: 20.h,),
                            ]
                        ),
                        TableRow(
                          children: [
                            TableCell(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('Taxe 15%: ',
                                        style: TextStyle(
                                            fontSize: 48.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[800])))),
                            TableCell(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('\$ 170.00',
                                        style: TextStyle(
                                            fontSize: 48.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey[600])))),
                          ],
                        ),
                        TableRow(
                            children: [
                              SizedBox(height: 20.h,),
                              SizedBox(height: 20.h,),
                            ]
                        ),
                        TableRow(
                          children: [
                            TableCell(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('Total: ',
                                        style: TextStyle(
                                            fontSize: 48.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[800])))),
                            TableCell(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('\$ 2 890.00',
                                        style: TextStyle(
                                            fontSize: 48.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[800])))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
