import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'fake_repository.dart';
import 'list_item.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: const Color(0xff8c7bc9),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Nouvelle commande",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Demande de prix',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Fournisseur',
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w100,
                  color: Colors.grey[700]),
            ),
            const TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 5),
                hintText: 'Nom, numéro de TVA, email ou référence',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Référence fournisseur',
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w100,
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
                  fontSize: 15.0,
                  fontWeight: FontWeight.w100,
                  color: Colors.grey[700]),
            ),
            TextField(
              readOnly: true, // Disable text editing
              onTap: () => _selectDate(context, "echeance"),
              decoration: InputDecoration(
                hintText:
                    selectedDates["echeance"]?.toString().substring(0, 10) ??
                        'Select Date',
                contentPadding: const EdgeInsets.only(left: 5),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Arrivée prévue',
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w100,
                  color: Colors.grey[700]),
            ),
            TextField(
              readOnly: true, // Disable text editing
              onTap: () => _selectDate(context, "arrivee"),

              decoration: InputDecoration(
                hintText:
                    selectedDates["arrivee"]?.toString().substring(0, 10) ??
                        'Select Date',
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
                        fontSize: 15.0,
                        fontWeight: FontWeight.w100,
                        color: Colors.grey[700])),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            TextButton(
              onPressed: () {},
              onHover: (_) {},
              child: Container(
                padding: const EdgeInsets.all(15),
                //margin: const EdgeInsets.symmetric(horizontal: 25, vertical : 50),
                decoration: BoxDecoration(
                  color: const Color(0xff8c7bc9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    "Ajouter",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text(
              'Produits',
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w100,
                  color: Colors.grey[700]),
            ),
            SizedBox(height: 20,),

            Expanded(
              child: ListView.builder(
                itemCount: _data.length + 1,
                itemBuilder: (context, index) {

                  if (index == _data.length) {
                    // Add Product button
                    return ElevatedButton(
                      onPressed: () {},
                      child: Text("Add Product"),
                    );
                  } else {
                    return Container(
                      child: ListItem(
                        fournisseur: _data[index].fournisseur,
                        montant: _data[index].montant,
                        id: _data[index].id,
                        date: _data[index].date,
                        etat: _data[index].etat,
                      ),
                    );
                  }
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
