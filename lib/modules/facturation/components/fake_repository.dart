import 'package:mobile_app/modules/facturation/clients/client_model.dart';
import 'package:mobile_app/modules/facturation/clients/client_repo.dart';

import 'data_model.dart';

class FakeRepo {
  final clients = ClientRepo.data;
  static List<DataModel> data = [
    DataModel(
      client: ClientModel(
          nomClient: 'Gemini Furniture',
          rue: '317 Fairchild Dr',
          ville: 'Fairfield',
          etat: 'CA',
          codePostal: '94535',
          pays: 'États-Unis',
          nTVA: 'US12345674',
          tel: '(941)-284-4875',
          email: 'gemini_furniture@fake.geminifurniture.com',
          siteWeb: 'http://www.gemini-furniture.com/'),
      montant: "48 000",
      refFac: "FAC/2024/00001",
      dateFac: "03/03/2024",
      dateEch: "05/03/2024",
      dateLiv: "03/03/2024",
      etat: "Comptabilisé",
    ),

  ];
}
