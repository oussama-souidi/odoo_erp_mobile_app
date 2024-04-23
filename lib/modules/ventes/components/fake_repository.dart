import '../../facturation/clients/client_repo.dart';
import 'data_model.dart';

class FakeRepo{
  static List<DataModel> data = [
    DataModel(
        client: ClientRepo.data[0],
        montant: "10000",
        id: "#P00010",
        date: "19/02/2024",
        etat: "Bon de commande"
    ),
    DataModel(
        client: ClientRepo.data[1],
        montant: "7600",
        id: "#P00012",
        date: "20/02/2024",
        etat: "Devis"
    ),
    DataModel(
        client: ClientRepo.data[0],
        montant: "2000",
        id: "#P00013",
        date: "21/02/2024",
        etat: "Envoyé"
    ),

  ];
}