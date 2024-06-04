import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import '../../../pages/login_page.dart';

class AddProduct extends StatefulWidget {
  AddProduct({super.key});



  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final nomProduit = TextEditingController();
  final refProduit = TextEditingController();
  final prixVente = TextEditingController();
  final cout = TextEditingController();
  final quantite = TextEditingController();



  Future<dynamic> addProductRPC() async {

    return odooClient.callKw(
      {
        'model': 'product.product',
        'method': 'create',
        'args': [
          {
            'name': nomProduit.text,
            'default_code': refProduit.text,
            'list_price': prixVente.text,
            'standard_price': cout.text,
            'qty_available' : quantite.text,
          }
        ],
        'kwargs': {}
      },
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
              "Nouveau produit",
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
                      'Ajouter produit',
                      style: TextStyle(
                          fontSize: 55.sp, fontWeight: FontWeight.bold),
                    ),
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
                      controller: nomProduit,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15.w),
                        hintText: 'par ex. Table',
                        hintStyle: TextStyle(
                            fontSize: 44.sp, fontWeight: FontWeight.normal),
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
                    TextField(
                      controller: refProduit,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 15.w)),
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
                      controller: prixVente,
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
                      controller: cout,
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
                      controller: quantite,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15.w),
                      ),
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                  ],
                ),
              ),
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
                    int productId = await addProductRPC();
                    print(quantite);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Product created successfully!"),
                    ));
                    Navigator.pop(context, true);
                  } on SocketException catch (e) {
                    // Handle connection problems
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Connection error"),
                    ));
                  } on OdooException catch (e) {
                    // Handle API errors (likely invalid credentials)
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Failed to create product."),
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
                onPressed: () {
                  Navigator.pop(context);
                },
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
