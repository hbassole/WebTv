class Direct {
  int id;
  String titre;
  String videoUrl;
  String imageUrl;
  String miniDescription;
  Auteur auteur;

  Direct({
    this.id,
    this.titre,
    this.videoUrl,
    this.imageUrl,
    this.miniDescription,
    this.auteur,
  });

  factory Direct.fromJson(Map<String, dynamic> json) => Direct(
    id: json["id"],
    titre: json["titre"],
    videoUrl: json["video_url"],
    imageUrl: json["image_url"],
    miniDescription: json["mini_description"],
    auteur: Auteur.fromJson(json["auteur"]),
  );

}


class Auteur {
  int id;
  String username;
  String firstName;
  String lastName;
  String email;

  Auteur({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
  });

  factory Auteur.fromJson(Map<String, dynamic> json) => Auteur(
    id: json["id"],
    username: json["username"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
  );

}
