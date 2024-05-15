import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/modules/facturation/clients/client_model.dart';
import 'package:mobile_app/modules/facturation/components/AddProduct.dart';
import 'package:mobile_app/modules/facturation/produits/data_model.dart';
import 'package:mobile_app/modules/facturation/produits/product_item.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import '../../../pages/login_page.dart';


class AddFact extends StatefulWidget {
  const AddFact({super.key});

  @override
  State<AddFact> createState() => _AddFactState();
}

class _AddFactState extends State<AddFact> {
  String? _selectedClient;
  DateTime? selectedDate;
  bool isChecked = false;
  final Map<String, DateTime?> selectedDates = {};
  final odooClient = OdooClient('http://10.0.2.2:8069');


  Future<dynamic> check() async {
    await odooClient.authenticate('demo', username, password);
  }

  Future<dynamic> partners() async {
    await check();
    return odooClient.callKw({
      'model': 'res.partner',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [],
        'fields': ['name'],
      },
    });
  }

  Future<dynamic> fetchProduits(String name) async {
    await check();
    return odooClient.callKw({
      'model': 'product.template',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': ['product_id', '=', name],
        'fields': ['name', 'price_unit', 'tax_ids'],
      },
    });
  }

  Widget buildListItem(Map<String, dynamic> record, String? quantite) {
    return ProductItem(
        produit: record['name'],
        quantite: quantite,
        prixUnitaire: record['price_unit'],
        prixHorsTax: (double.parse(record['price_unit'].toString()) *
                double.parse(quantite!))
            .toStringAsFixed(2),
        prixAvecTax: ((double.parse(record['price_unit'].toString()) *
                    double.parse(quantite)) *
                1.15)
            .toStringAsFixed(2));
  }

  Future<void> _selectDate(BuildContext context, String dateKey) async {
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDates[dateKey] ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDates[dateKey] = pickedDate;
      });
    }
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
              "Nouvelle facture",
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
                        TextStyle(fontSize: 55.sp, fontWeight: FontWeight.bold),
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
                  FutureBuilder(
                    future: partners(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        List<dynamic> partners = snapshot.data!;
                        List<String> partnerNames = [];
                        partnerNames = partners
                            .map((partner) => partner['name'] as String)
                            .toList();
                        return DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedClient,
                          items: partnerNames
                              .map((String client) => DropdownMenuItem(
                                    value: client,
                                    child: Text(client),
                                  ))
                              .toList(),
                          onChanged: (String? newClient) {
                            setState(() {
                              _selectedClient = newClient;
                            });
                          },
                        );
                      } else {
                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
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
                  TextField(
                    readOnly: true, // Disable text editing
                    onTap: () => _selectDate(context, "dateFac"),
                    decoration: InputDecoration(
                      hintText:
                          selectedDates["dateFac"]?.toString().substring(0, 10),
                      hintStyle: TextStyle(
                          fontSize: 44.sp, fontWeight: FontWeight.normal),
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
                  TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15.w)),
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
                  TextField(
                    readOnly: true, // Disable text editing
                    onTap: () => _selectDate(context, "dateEch"),
                    decoration: InputDecoration(
                      hintText:
                          selectedDates["dateEch"]?.toString().substring(0, 10),
                      hintStyle: TextStyle(
                          fontSize: 44.sp, fontWeight: FontWeight.normal),
                      contentPadding: EdgeInsets.only(left: 15.w),
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
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
                    height: 20.h,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AjouterProduit()));
                    },
                    onHover: (_) {},
                    child: Container(
                      padding: EdgeInsets.all(30.sp),
                      //margin: const EdgeInsets.symmetric(horizontal: 25, vertical : 50),
                      decoration: BoxDecoration(
                        color: const Color(0xffa08fde),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "Ajouter",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 44.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  for (var product in selectedProducts)
                    ProductItem(
                        produit: product.produit,
                        quantite: product.quantite,
                        prixUnitaire: product.prixUnitaire,
                        prixHorsTax: product.prix_horsTax,
                        prixAvecTax: product.prix_avecTax)
                  /*for (var data in selectedProducts)
                    FutureBuilder(
                      future: fetchProduits(data['produit']!),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          return buildListItem(snapshot.data, data['quantite']);
                        } else {
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }
                          return const CircularProgressIndicator();
                        }
                      },

                    )*/
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.r),
              topRight: Radius.circular(50.r),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
              )
            ]),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(vertical: 30.h, horizontal: 50.w),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Circular border
                  ),
                  backgroundColor: const Color(0xff8c7bc9),
                  foregroundColor: Colors.white,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  // Shadow color
                  // Shadow offset
                  elevation: 2.0, // Button elevation for shadow
                ),
                child: Text(
                  "Confirmer",
                  style: TextStyle(fontSize: 45.sp),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(vertical: 30.h, horizontal: 50.w),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Circular border
                  ),
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  elevation: 2.0, // Button elevation for shadow
                ),
                child: Text("Annuler", style: TextStyle(fontSize: 45.sp)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
