import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/modules/facturation/clients/client_model.dart';
import 'package:mobile_app/modules/facturation/clients/detailsClient.dart';
import 'package:mobile_app/modules/facturation/clients/client_repo.dart';
import 'package:mobile_app/modules/facturation/produits/fake_repository.dart';
import 'package:mobile_app/modules/facturation/produits/product_item.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import '../../../pages/login_page.dart';

class DetailsFac extends StatelessWidget {
  final String client;
  final String montant;
  final String refFac;
  final String id;
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
      required this.id,
      required this.dateFac,
      required this.dateEch,
      required this.dateLiv,
      required this.etat});
  final odooClient = OdooClient('http://10.0.2.2:8069');
  final montantHT = 0.00;
  final tax = 0.00;



  Future<dynamic> check() async {
    await odooClient.authenticate('demo', username, password);
  }

  Future<dynamic> fetchProduits() async {
    await check();
    return odooClient.callKw({
      'model': 'account.move.line',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
          ['move_id', '=', refFac], ['product_id', '!=', false]
        ],
        'fields': [
          'product_id',
          'quantity',
          'price_unit',
          'price_subtotal',
          'price_total'
        ],
      },
    });
  }
  Widget buildListItem(Map<String, dynamic> record) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: ProductItem(
          produit: record['product_id'][1].split(']').last.trim().toString(),
          quantite: record['quantity'].toString(),
          prixUnitaire: record['price_unit'].toString(),
          prixHorsTax: record['price_subtotal'].toString(),
          prixAvecTax: record['price_total'].toString()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
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
                  Text(
                    client,
                    style: TextStyle(
                        fontSize: 47.sp,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w400),
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
                  FutureBuilder(
                      future: fetchProduits(),
                      builder:
                          (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          return
                            SizedBox(
                              height: snapshot.data.length * 370.h,
                              child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    final record =
                                    snapshot.data[index] as Map<String, dynamic>;
                                    return buildListItem(record);
                                  }),
                            );
                        } else {
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }
                          return const CircularProgressIndicator();
                        }
                      }),
                  /*for (var data in produits)
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 30.w),
                      child: ProductItem(
                          produit: data.produit,
                          quantite: data.quantite,
                          prixUnitaire: data.prixUnitaire,
                          prixHorsTax: data.prix_horsTax,
                          prixAvecTax: data.prix_avecTax),
                    )*/
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.h),
              child: SizedBox(
                height: 300.h,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment
                        .middle, // Add space between rows
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
                                  child: Text('\$ ${(double.parse(montant)/1.15).toStringAsFixed(2)}',
                                      style: TextStyle(
                                          fontSize: 48.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[800])))),
                        ],
                      ),
                      TableRow(children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ]),
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
                                  child: Text('\$ ${(double.parse(montant) - double.parse(montant)/1.15).toStringAsFixed(2)}',
                                      style: TextStyle(
                                          fontSize: 48.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[600])))),
                        ],
                      ),
                      TableRow(children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ]),
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
                                  child: Text('\$ $montant',
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
      ),
    );
  }
}
