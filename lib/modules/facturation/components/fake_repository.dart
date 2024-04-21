import 'package:mobile_app/modules/facturation/clients/client_model.dart';
import 'package:mobile_app/modules/facturation/clients/client_repo.dart';

import 'data_model.dart';

class FakeRepo {
  static List<DataModel> data = [
    DataModel(
      client: ClientRepo.data[0],
      montant: "48 000",
      refFac: "FAC/2024/00001",
      dateFac: "03/03/2024",
      dateEch: "05/03/2024",
      dateLiv: "03/03/2024",
      etat: "Comptabilisé",
    ),
    DataModel(
      client: ClientRepo.data[1],
      montant: "18 000",
      refFac: "FAC/2024/00002",
      dateFac: "03/03/2024",
      dateEch: "05/03/2024",
      dateLiv: "03/03/2024",
      etat: "Brouillon",
    ),

  ];
}
