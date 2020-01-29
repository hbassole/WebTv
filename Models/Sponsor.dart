
class Sponsor {
  int id;
  List<ConcoursSponsor> concoursSponsors;
  String nom;
  String logo;
  String site;

  Sponsor({
    this.id,
    this.concoursSponsors,
    this.nom,
    this.logo,
    this.site,

  });

  factory Sponsor.fromJson(Map<String, dynamic> json) => Sponsor(
    id: json["id"],
    concoursSponsors: List<ConcoursSponsor>.from(json["concours_sponsors"].map((x) => ConcoursSponsor.fromJson(x))),
    nom: json["nom"],
    logo: json["logo"],
    site: json["site"],
  );

}

class ConcoursSponsor {
  int id;
  List<dynamic> resultatsConcours;
  String titre;
  String cover;
  String titreSlug;
  String recompenses;
  String description;
  DateTime dateDebut;
  DateTime dateFin;
  bool status;
  DateTime dateAdd;
  DateTime dateUpd;
  List<int> sponsors;

  ConcoursSponsor({
    this.id,
    this.resultatsConcours,
    this.titre,
    this.cover,
    this.recompenses,
    this.description,
    this.dateDebut,
    this.dateFin,
    this.sponsors,
  });

  factory ConcoursSponsor.fromJson(Map<String, dynamic> json) => ConcoursSponsor(
    id: json["id"],
    resultatsConcours: List<dynamic>.from(json["resultats_concours"].map((x) => x)),
    titre: json["titre"],
    cover: json["cover"],
    recompenses: json["recompenses"],
    description: json["description"],
    dateDebut: DateTime.parse(json["date_debut"]),
    dateFin: DateTime.parse(json["date_fin"]),
    sponsors: List<int>.from(json["sponsors"].map((x) => x)),
  );

}
