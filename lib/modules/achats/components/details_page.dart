import 'package:flutter/material.dart';
import 'package:mobile_app/modules/achats/produits/ajouter_produit.dart';
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
  double responsiveFontSize(BuildContext context, double referenceFontSize) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    double averageDimension = (screenWidth + screenHeight) / 2;

    double responsiveSize = referenceFontSize * (averageDimension / 480);

    return responsiveSize;
  }

  // for a responsive padding
  EdgeInsets responsivePadding(BuildContext context, double horizontalFactor,
      double verticalFactor) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    double horizontalPadding = screenWidth * horizontalFactor;
    double verticalPadding = screenHeight * verticalFactor;

    return EdgeInsets.symmetric(
      horizontal: horizontalPadding,
      vertical: verticalPadding,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .surface,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
        title: Text(
          "Nouvelle commande",
          style: TextStyle(
              color: Colors.black87, fontSize: responsiveFontSize(context, 17)),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Demande de prix',
                  style: TextStyle(
                      fontSize: responsiveFontSize(context, 15),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Fournisseur',
                  style: TextStyle(
                      fontSize: responsiveFontSize(context, 13),
                      fontWeight: FontWeight.w300,
                      color: Colors.grey[700]),
                ),
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 5),
                    hintText: 'Nom, numéro de TVA, email ou référence',
                    hintStyle:
                    TextStyle(fontSize: responsiveFontSize(context, 13),
                        fontWeight: FontWeight.normal),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Référence fournisseur',
                  style: TextStyle(
                      fontSize: responsiveFontSize(context, 13),
                      fontWeight: FontWeight.w300,
                      color: Colors.grey[700]),
                ),
                const TextField(
                  decoration:
                  InputDecoration(contentPadding: EdgeInsets.only(left: 5)),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Échéance de commande',
                  style: TextStyle(
                      fontSize: responsiveFontSize(context, 13),
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
                        fontSize: responsiveFontSize(context, 13),
                        fontWeight: FontWeight.normal),
                    contentPadding: const EdgeInsets.only(left: 5),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Arrivée prévue',
                  style: TextStyle(
                      fontSize: responsiveFontSize(context, 13),
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
                        fontSize: responsiveFontSize(context, 13),
                        fontWeight: FontWeight.normal),
                    contentPadding: const EdgeInsets.only(left: 5),
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                            fontSize: responsiveFontSize(context, 13),
                            fontWeight: FontWeight.w300,
                            color: Colors.grey[700])),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Produits',
                  style: TextStyle(
                      fontSize: responsiveFontSize(context, 15),
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 30,
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
                    padding: const EdgeInsets.all(10),
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
                          fontSize: responsiveFontSize(context, 13),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                      for(var data in _data)
                        Padding(
                          padding: responsivePadding(context, 0,0.008),
                          child: ProductItem(
                              produit: data.produit,
                              quantite: data.quantite,
                              prixUnitaire: data.prixUnitaire,
                              prix_horsTax: data.prix_horsTax,
                              prix_avecTax: data.prix_avecTax),
                        )
                    ],

                ),
                /*SizedBox(
                  height: _data.length * 130,
                  child: GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisExtent: 120,
                          mainAxisSpacing: 10),
                      itemCount: _data.length,
                      itemBuilder: (context, index) {
                        return ProductItem(
                            produit: _data[index].produit,
                            quantite: _data[index].quantite,
                            prixUnitaire: _data[index].prixUnitaire,
                            prix_horsTax: _data[index].prix_horsTax,
                            prix_avecTax: _data[index].prix_avecTax);
                      }),
                ),*/
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(20),
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const details_page()));
                },
                style: TextButton.styleFrom(
                  padding: responsivePadding(context, 0.05, 0.015),
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
                child: Text("Confirmer",
                  style: TextStyle(fontSize: responsiveFontSize(context, 13)),),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const details_page()));
                },
                style: TextButton.styleFrom(
                  padding: responsivePadding(context, 0.05, 0.015),
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
                child: Text("Imprimer", style: TextStyle(
                    fontSize: responsiveFontSize(context, 13))),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const details_page()));
                },
                style: TextButton.styleFrom(
                  padding: responsivePadding(context, 0.05, 0.015),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(10.0), // Circular border
                  ),
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  elevation: 2.0, // Button elevation for shadow
                ),
                child: Text("Annuler", style: TextStyle(
                    fontSize: responsiveFontSize(context, 13))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
