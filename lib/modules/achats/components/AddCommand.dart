import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/modules/achats/produits/AddProduct.dart';
import 'package:mobile_app/modules/achats/produits/fake_repository.dart';
import 'package:mobile_app/modules/achats/produits/product_item.dart';

class details_page extends StatefulWidget {
  const details_page({super.key});

  @override
  State<details_page> createState() => _details_pageState();
}

class _details_pageState extends State<details_page> {
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
      backgroundColor: Theme.of(context).colorScheme.surface,
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 65.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  'Demande de prix',
                  style:
                      TextStyle(fontSize: 55.sp, fontWeight: FontWeight.bold),
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
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15.w),
                    hintText: 'Nom, numéro de TVA, email ou référence',
                    hintStyle: TextStyle(
                        fontSize: 44.sp, fontWeight: FontWeight.normal),
                  ),
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
                    hintText:
                        selectedDates["arrivee"]?.toString().substring(0, 10) ??
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
                SizedBox(
                  height: 50.h,
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
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "Ajouter produit",
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
                Column(
                  children: [
                    for (var data in _data)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: ProductItem(
                            produit: data.produit,
                            quantite: data.quantite,
                            prixUnitaire: data.prixUnitaire,
                            prix_horsTax: data.prix_horsTax,
                            prix_avecTax: data.prix_avecTax),
                      )
                  ],
                ),
              ],
            ),
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
