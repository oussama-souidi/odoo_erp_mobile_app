import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/modules/achats/produits/AddProduct.dart';
import 'package:mobile_app/modules/achats/produits/product_item.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:mobile_app/modules/achats/produits/data_model.dart';

import '../../../components/pdf/downladPDF.dart';
import '../../../components/pdf/generateInvoice.dart';
import '../../../pages/login_page.dart';

List<DataModel> selectedProducts = [];

class AddCommand extends StatefulWidget {
  const AddCommand({super.key});

  @override
  State<AddCommand> createState() => _AddCommandState();
}

class _AddCommandState extends State<AddCommand> {
  DateTime? selectedDate;
  bool isChecked = false;
  String? _selectedClient;
  int? _selectedClientID;
  final Map<String, DateTime?> selectedDates = {};
  final odooClient = OdooClient('http://10.0.2.2:8069');

  Future<dynamic> check() async {
    await odooClient.authenticate('demo', username, password);
  }

  Future<dynamic> fetchFournisseurs() async {
    await check();
    return odooClient.callKw({
      'model': 'res.partner',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [],
        'fields': ['name', 'id'],
      },
    });
  }
  Future<dynamic> addPurchaseRPC() async {
    await check();
    return odooClient.callKw(
      {
        'model': 'purchase.order',
        'method': 'create',
        'args': [
          {
            'partner_id': _selectedClientID,
            'order_line': selectedProducts.map((product) {
              return [
                0,
                0,
                {
                  'product_id': product.id,
                  'product_qty': double.parse(product.quantite),
                  'price_unit': double.parse(product.prixUnitaire),
                },
              ];
            }).toList(),
          }
        ],
        'kwargs': {}
      },
    );
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
              "Nouvelle commande",
              style: TextStyle(color: Colors.black87, fontSize: 55.sp),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey.shade100,
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
                      'Demande de prix',
                      style: TextStyle(
                          fontSize: 55.sp, fontWeight: FontWeight.bold),
                    ),
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
                    FutureBuilder(
                      future: fetchFournisseurs(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          List<dynamic> partners = snapshot.data!;
                          List<String> partnerNames = [];
                          partnerNames = partners
                              .map((partner) => partner['name'] as String)
                              .toList();
                          List<int> partnerIDS = [];
                          partnerIDS = partners
                              .map((partner) => partner['id'] as int)
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
                                _selectedClientID = partnerIDS[
                                    partnerNames.indexOf(_selectedClient!)];
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
                      'Référence fournisseur',
                      style: TextStyle(
                          fontSize: 44.sp,
                          fontWeight: FontWeight.w300,
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
                      'Échéance de commande',
                      style: TextStyle(
                          fontSize: 44.sp,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[700]),
                    ),
                    TextField(
                      readOnly: true, // Disable text editing
                      onTap: () => _selectDate(context, "echeance"),
                      decoration: InputDecoration(
                        hintText: selectedDates["echeance"]
                                ?.toString()
                                .substring(0, 10) ??
                            'Choisir date',
                        hintStyle: TextStyle(
                            fontSize: 44.sp, fontWeight: FontWeight.normal),
                        contentPadding: EdgeInsets.only(left: 15.w),
                      ),
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    Text(
                      'Arrivée prévue',
                      style: TextStyle(
                          fontSize: 44.sp,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[700]),
                    ),
                    TextField(
                      readOnly: true, // Disable text editing
                      onTap: () => _selectDate(context, "arrivee"),

                      decoration: InputDecoration(
                        hintText: selectedDates["arrivee"]
                                ?.toString()
                                .substring(0, 10) ??
                            'Choisir date',
                        hintStyle: TextStyle(
                            fontSize: 44.sp, fontWeight: FontWeight.normal),
                        contentPadding: EdgeInsets.only(left: 15.w),
                      ),
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? newValue) {
                            setState(() {
                              isChecked = newValue!;
                            });
                          },
                        ),
                        Text('Demande de confirmation',
                            style: TextStyle(
                                fontSize: 44.sp,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey[700])),
                      ],
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    Text(
                      'Produits',
                      style: TextStyle(
                          fontSize: 55.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const Divider(),
                    SizedBox(
                      height: 50.h,
                    ),
                    TextButton(
                      onPressed: () async {

                        final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AjouterProduit()));
                        if (result == true){
                          setState(() {});
                        }
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
                            "Ajouter produit",
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
                  ],
                ),
              ),
              /*Padding(
                padding: EdgeInsets.only(bottom: 50.h),
                child: Column(
                  children: [
                    for (var data in _data)
                      ProductItem(
                          produit: data.produit,
                          quantite: data.quantite,
                          prixUnitaire: data.prixUnitaire,
                          prixHorsTax: data.prix_horsTax,
                          prixAvecTax: data.prix_avecTax)
                  ],
                ),
              ),*/
            ],
          ),
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () async {
                  try {
                    int productId = await addPurchaseRPC();
                    selectedProducts = [];
                    Navigator.pop(context, true);
                  } on SocketException catch (e) {
                    // Handle connection problems
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Connection error"),
                    ));
                  } on OdooException catch (e) {
                    // Handle API errors (likely invalid credentials)
                    print(e);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Failed to create invoice."),
                    ));
                  } catch (e) {
                    // Handle API errors
                    print("Unexpected error: $e");
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please try again later."),
                    ));
                  }
                },
                style: TextButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(vertical: 30.h, horizontal: 45.w),
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
                onPressed: () async {
                  try {
                    String customerName = "foulen";
                    String invoiceNumber = "55555";
                    double amount = 3000;
                    final pdfBytesFuture =
                        generateInvoicePdf(customerName, invoiceNumber, amount);
                    await downloadPdf(pdfBytesFuture);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Invoice downloaded successfully!'),
                      ),
                    );
                  } on Exception catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error downloading invoice: $error'),
                      ),
                    );
                  }
                },
                style: TextButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(vertical: 30.h, horizontal: 45.w),
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
                  elevation: 2.0,
                  // Button elevation for shadow
                ),
                child: Text("Imprimer", style: TextStyle(fontSize: 45.sp)),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(vertical: 30.h, horizontal: 45.w),
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
