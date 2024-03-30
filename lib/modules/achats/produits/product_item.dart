import 'package:flutter/material.dart';


class ProductItem extends StatelessWidget {
  final String produit;
  final String quantite;
  final String prixUnitaire;
  final String prix_horsTax;
  final String prix_avecTax;

  const ProductItem({super.key, required this.produit, required this.quantite, required this.prixUnitaire, required this.prix_horsTax, required this.prix_avecTax});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 1),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
                offset: Offset(0, 3))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 8.0, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.produit,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Quantite : "+ this.quantite,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[700]),
                    ),
                  ],
                ),
                Text(
                  "Prix unitaire : "+ this.prixUnitaire,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 8.0, horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("HT : \n "+this.prix_horsTax,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Text("TTC: \n "+this.prix_avecTax,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );;
  }
}
