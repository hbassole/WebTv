class Concour {
  int id;
  String titre;
  String cover;
  String titreSlug;
  String recompenses;
  String description;

  Concour({
    this.id,
    this.titre,
    this.cover,
    this.titreSlug,
    this.recompenses,
    this.description,
  });

  factory Concour.fromJson(Map<String, dynamic> json) => Concour(
    id: json["id"],
    titre: json["titre"],
    cover: json["cover"],
    titreSlug: json["titre_slug"],
    recompenses: json["recompenses"],
    description: json["description"],
  );

}
