import 'package:flutter/material.dart';


class ProductItem extends StatelessWidget {
  /*final String fournisseur;
  final String montant;
  final String id;
  final String date;
  final String etat;*/

  const ProductItem({super.key});

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
                vertical: 8.0, horizontal: 20),
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
                      "Produit 1",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Quantite : 1.00",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w100,
                          color: Colors.grey[700]),
                    ),
                  ],
                ),
                Text(
                  "Prix unitaire : 200.00",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w100,
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
                Text("Hors taxes : \n 600",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Text("Avec taxes: \n 690",
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
