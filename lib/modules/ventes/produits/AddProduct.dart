import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/modules/ventes/produits/data_model.dart';
import 'package:mobile_app/modules/ventes/components/AddCommand.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import '../../../components/appBar.dart';
import '../../../pages/login_page.dart';


class AjouterProduit extends StatefulWidget {
  const AjouterProduit({super.key});

  @override
  State<AjouterProduit> createState() => _AjouterProduitState();
}

class _AjouterProduitState extends State<AjouterProduit> {
  String? _selectedProduct;

  DataModel selectedProduct = DataModel(
      id: 0,
      produit: '',
      quantite: '',
      prixUnitaire: '',
      prix_horsTax: '',
      prix_avecTax: '');

  final quantite = TextEditingController();
  final odooClient = OdooClient('http://10.0.2.2:8069');

  Future<dynamic> check() async {
    await odooClient.authenticate('demo', username, password);
  }

  Future<dynamic> products() async {
    await check();
    return odooClient.callKw({
      'model': 'product.product',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [],
        'fields': ['name', 'list_price','id'],
      },
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(145.h),
        child: const appBar(
          title: "Créer Ligne de commande",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 70.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70.h,
              ),
              Text(
                'Produit',
                style: TextStyle(
                    fontSize: 50.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              FutureBuilder(
                future: products(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    List<dynamic> products = snapshot.data!;
                    List<String> productNames = [];
                    productNames = products
                        .map((product) => product['name'] as String)
                        .toSet()
                        .toList();
                    return DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedProduct,
                      items: productNames
                          .map((String product) => DropdownMenuItem(
                        value: product,
                        child: Text(product),
                      ))
                          .toList(),
                      onChanged: (String? newproduct) {
                        setState(() {
                          _selectedProduct = newproduct;
                          for (var product in products) {
                            if (product['name'] == _selectedProduct) {
                              selectedProduct = DataModel(
                                  id: product['id'],
                                  produit: product['name'],
                                  quantite: '',
                                  prixUnitaire:
                                  product['list_price'].toString(),
                                  prix_horsTax: '',
                                  prix_avecTax: '');
                            }
                          }
                        });
                      },
                    );
                  } else {
                    if (snapshot.hasError) {
                      const CircularProgressIndicator();
                      return Text(snapshot.error.toString());
                    }
                    return const CircularProgressIndicator();
                  }
                },
              ),
              /*const TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 5),
                  hintText: 'Choisir un produit',
                ),
              ),*/
              SizedBox(
                height: 70.h,
              ),
              Text(
                'Quantité',
                style: TextStyle(
                    fontSize: 50.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              TextFormField(
                controller: quantite..text = '1.0',
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 15.w),
                ),
              ),
              SizedBox(
                height: 70.h,
              ),
              Text(
                'Taxes',
                style: TextStyle(
                    fontSize: 50.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15.w),
                    hintText: "0%"),
              ),
              SizedBox(
                height: 70.h,
              ),
              Text(
                'Description',
                style: TextStyle(
                    fontSize: 50.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 15.w))),
              SizedBox(
                height: 90.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      selectedProduct.quantite = quantite.text;
                      selectedProduct.prix_horsTax = (double.parse(
                          selectedProduct.prixUnitaire.toString()) *
                          double.parse(quantite.text))
                          .toStringAsFixed(2);
                      selectedProduct.prix_avecTax = ((double.parse(
                          selectedProduct.prixUnitaire.toString()) *
                          double.parse(quantite.text)) *
                          1.15)
                          .toStringAsFixed(2);
                      selectedProducts.add(DataModel(
                          id: selectedProduct.id,
                          produit: selectedProduct.produit,
                          quantite: selectedProduct.quantite,
                          prixUnitaire: selectedProduct.prixUnitaire,
                          prix_horsTax: selectedProduct.prix_horsTax,
                          prix_avecTax: selectedProduct.prix_avecTax));
                      Navigator.pop(context, true);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 60.w, vertical: 40.h),
                      // Add padding
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
                      "Enregistrer & Fermer",
                      style: TextStyle(fontSize: 40.sp),
                    ),
                  ),
                  SizedBox(width: 60.w), // Add spacing between buttons
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 60.w, vertical: 40.h),
                      // Add padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10.0), // Circular border
                      ),
                      backgroundColor: const Color(0xff8c7bc9),
                      foregroundColor: Colors.white,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      elevation: 2.0, // Button elevation for shadow
                    ),
                    child: Text(
                      "Annuler",
                      style: TextStyle(fontSize: 40.sp),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
