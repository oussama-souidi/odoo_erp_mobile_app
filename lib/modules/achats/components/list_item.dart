import 'package:flutter/material.dart';


class ListItem extends StatelessWidget {
  final String fournisseur;
  final String montant;
  final String id;
  final String date;
  final String etat;

  const ListItem({required this.fournisseur, required this.montant, required this.id, required this.date, required this.etat});

  @override
  Widget build(BuildContext context) {
    Color boxColor;
    String text = this.etat;
    Color borderColor;
    TextStyle textStyle;

    switch (text) {
      case "Bon de commande fournisseur":
        boxColor = const Color(0xffbda7d1); // Light purple
        borderColor = Colors.transparent;
        textStyle = const TextStyle(color: Colors.white, fontSize: 12.0);
        break;
      case "envoyé":
        boxColor = const Color(0xffbda7d1);
        borderColor = Colors.transparent;
        textStyle = const TextStyle(color: Colors.white, fontSize: 12.0);
        break;
      case "demande de prix":
        boxColor = Colors.white;
        borderColor = const Color(0xffbda7d1);
        textStyle = const TextStyle(color: Colors.black, fontSize: 12.0);
        break;
      default:
        // Handle unexpected text by setting default styles (optional)
        boxColor = Colors.grey.shade200;
        borderColor = Colors.transparent;
        textStyle = const TextStyle(color: Colors.black, fontSize: 12.0);
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 2),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5,
                  offset: Offset(0, 3))
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text( this.fournisseur
                    ,
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$'+ this.montant,
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        this.id,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w100,
                            color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        this.date,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w100,
                            color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: boxColor,
                        border: Border.all(color: borderColor),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                      child: Text(text,
                          style:
                              textStyle),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
