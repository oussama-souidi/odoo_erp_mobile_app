class ClientModel {
  final String nomClient;
  final String rue;
  final String ville;
  final String etat;
  final String codePostal;
  final String pays;
  final String nTVA;
  final String tel;
  final String email;
  final String siteWeb;
  final String imageUrl;

  ClientModel({
    required this.nomClient,
    required this.rue,
    required this.ville,
    required this.etat,
    required this.codePostal,
    required this.pays,
    required this.nTVA,
    required this.tel,
    required this.email,
    required this.siteWeb,
    required this.imageUrl
  });
}
