import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/modules/facturation/clients/client_model.dart';
import 'package:mobile_app/modules/facturation/clients/client_repo.dart';
import 'package:mobile_app/modules/facturation/produits/product_item.dart';

import '../../achats/produits/AddProduct.dart';

class AddFact extends StatefulWidget {
  const AddFact({super.key});

  @override
  State<AddFact> createState() => _AddFactState();
}

class _AddFactState extends State<AddFact> {
  ClientModel? _selectedClient;
  DateTime? selectedDate;
  bool isChecked = false;
  final Map<String, DateTime?> selectedDates = {};
  final _data = FakeRepo.data;

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
  // for a responsive font size
  /*double responsiveFontSize(BuildContext context, double referenceFontSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double averageDimension = (screenWidth + screenHeight) / 2;

    double responsiveSize = referenceFontSize * (averageDimension / 480);

    return responsiveSize;
  }

  // for a responsive padding
  EdgeInsets responsivePadding(
      BuildContext context, double horizontalFactor, double verticalFactor) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double horizontalPadding = screenWidth * horizontalFactor;
    double verticalPadding = screenHeight * verticalFactor;

    return EdgeInsets.symmetric(
      horizontal: horizontalPadding,
      vertical: verticalPadding,
    );
  }*/

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
                  DropdownButton<ClientModel>(
                    isExpanded: true,
                    value: _selectedClient,
                    items: FakeRepo.data.map((client) => DropdownMenuItem(
                      value: client,
                      child: Text(client.nomClient),
                    )).toList(),
                    onChanged: (ClientModel? newClient) {
                      setState(() {
                        _selectedClient = newClient;
                      });
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
                      hintText: selectedDates["dateFac"]
                          ?.toString()
                          .substring(0, 10),
                      hintStyle: TextStyle(
                          fontSize: 44.sp, fontWeight: FontWeight.normal),
                      contentPadding: EdgeInsets.only(left: 15.w),
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  Text(
                    'Référence fournisseur',
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
                    'Lignes de facture',
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
                    onPressed: () {
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AjouterProduit()));
                    */},
                    onHover: (_) {},
                    child: Container(
                      padding: EdgeInsets.all(30.sp),
                      //margin: const EdgeInsets.symmetric(horizontal: 25, vertical : 50),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "Ajouter",
                          style: TextStyle(
                            color: Colors.black,
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
                onPressed: () {},
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
                onPressed: () {},
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
