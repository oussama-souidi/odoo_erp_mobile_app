import 'package:flutter/material.dart';

class AjouterProduit extends StatefulWidget {
  const AjouterProduit({super.key});

  @override
  State<AjouterProduit> createState() => _details_pageState();
}

class _details_pageState extends State<AjouterProduit> {
  DateTime? selectedDate;

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
      appBar: AppBar(
        backgroundColor: const Color(0xff8c7bc9),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Créer Lignes de commande",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Produit',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              const TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 5),
                  hintText: 'Choisir un produit',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Quantité',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              const TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 5), hintText: "1.00"),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Prix unitaire',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              const TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 5), hintText: "0.00"),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Taxes',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              const TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 5)),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Arrivée prévue',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              TextField(
                readOnly: true, // Disable text editing
                onTap: () => _selectDate(context, "arrivee"),

                decoration: InputDecoration(
                  hintText: selectedDate?.toString().substring(0, 10) ??
                      'Choisir date',
                  contentPadding: const EdgeInsets.only(left: 5),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
