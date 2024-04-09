import 'data_model.dart';

class FakeRepo{
  static List<DataModel> data = [
    DataModel(
        fournisseur: "Azure Interior",
        montant: "10000",
        id: "#P00010",
        date: "19/02/2024",
        etat: "Bon de commande"
    ),
    DataModel(
        fournisseur: "Meubla",
        montant: "5400",
        id: "#P00011",
        date: "18/02/2024",
        etat: "Bon de commande"
    ),
    DataModel(
        fournisseur: "Azure",
        montant: "7600",
        id: "#P00012",
        date: "20/02/2024",
        etat: "demande de prix"
    ),
    DataModel(
        fournisseur: "Interior",
        montant: "2000",
        id: "#P00013",
        date: "21/02/2024",
        etat: "envoyé"
    ),

  ];
}