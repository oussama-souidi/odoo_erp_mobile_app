import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/modules/achats/produits/fake_repository.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import '../../../components/appBar.dart';
import '../../../pages/login_page.dart';
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

  final odooClient = OdooClient('http://10.0.2.2:8069');
  final montantHT = 0.00;
  final tax = 0.00;

  Future<dynamic> check() async {
    await odooClient.authenticate('demo', username, password);
  }

  Future<dynamic> fetchProduits() async {
    await check();
    return odooClient.callKw({
      'model': 'purchase.order.line',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
          ['order_id', '=', id]
        ],
        'fields': [
          'product_id',
          'product_qty',
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
          quantite: record['product_qty'].toString(),
          prixUnitaire: record['price_unit'].toString(),
          prixHorsTax: record['price_subtotal'].toString(),
          prixAvecTax: record['price_total'].toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    String text = etat;
    switch (text) {
      case 'purchase':
        text = 'Bon de commande';
        break;
      case 'sent':
        text = 'Envoyé';
        break;
      case 'draft':
        text = 'Demande de prix';
        break;
      case 'done':
        text = 'Verrouillé';
        break;
      case 'to approve':
        text = 'A approuver';
        break;
      case 'cancel':
        text = 'Annulé';
        break;
      default:
        text = etat;
    }
    return Scaffold(
        backgroundColor: const Color(0xfff7f7f7),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(145.h),
          child: const appBar(
            title: "Détails de commande",
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
                      'Fournisseur',
                      style: TextStyle(
                          fontSize: 44.sp,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[700]),
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: fournisseur,
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
                      initialValue: montant.toString(),
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
                      initialValue: id,
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
                      initialValue: date,
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
                      initialValue: text,
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
                  FutureBuilder(
                      future: fetchProduits(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          return SizedBox(
                            height: snapshot.data.length * 370.h,
                            child: ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  final record = snapshot.data[index]
                                      as Map<String, dynamic>;
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
                  /*for (var data in _data)
                    Padding(
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
                                    child: Text(
                                        '\$ ${(double.parse(montant) / 1.15).toStringAsFixed(2)}',
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
                                    child: Text(
                                        '\$ ${(double.parse(montant) - double.parse(montant) / 1.15).toStringAsFixed(2)}',
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
        ));
  }
}
