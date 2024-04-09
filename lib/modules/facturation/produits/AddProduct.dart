import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/modules/achats/produits/data_model.dart';
import 'package:mobile_app/modules/achats/produits/fake_repository.dart';

import '../../../components/appBar.dart';

class AjouterProduit extends StatefulWidget {
  const AjouterProduit({super.key});

  @override
  State<AjouterProduit> createState() => _AjouterProduitState();
}

class _AjouterProduitState extends State<AjouterProduit> {
  DateTime? selectedDate;
  DataModel? _selectedProduct;

  Future<void> _selectDate(BuildContext context, String dateKey) async {
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(145.h),
        child: const appBar(
          title: "Créer Ligne de facture",
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
              DropdownButton<DataModel>(
                isExpanded: true,
                hint: const Text('Choisir un produit'),
                value: _selectedProduct,
                items: FakeRepo.data
                    .map((product) => DropdownMenuItem(
                          value: product,
                          child: Text(product.produit),
                        ))
                    .toList(),
                onChanged: (DataModel? newProduct) {
                  setState(() {
                    _selectedProduct = newProduct;
                  });
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
              TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15.w),
                    hintText: "1.00"),
              ),
              SizedBox(
                height: 70.h,
              ),
              Text(
                'Prix unitaire',
                style: TextStyle(
                    fontSize: 50.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15.w),
                    hintText: "0.00"),
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
                    onPressed: () {},
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
                    onPressed: () {},
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
