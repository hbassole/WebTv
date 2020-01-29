class CategorieVideo {
  int id;
  List<dynamic> videoCommentaire;
  List<Vue> vues;
  List<dynamic> videoLike;
  List<dynamic> videoDislike;
  List<dynamic> resultatsVideo;
  String titre;
  String titreSlug;
  dynamic imagePreview;
  String imageUrl;
  dynamic video;
  String videoUrl;
  String miniDescription;
  bool attente;
  String duree;
  bool status;
  DateTime dateAdd;
  DateTime dateUpd;
  Auteur auteur;
  Categorie categorie;
  dynamic concours;
  List<dynamic> tague;

  CategorieVideo({
    this.id,
    this.videoCommentaire,
    this.vues,
    this.videoLike,
    this.videoDislike,
    this.resultatsVideo,
    this.titre,
    this.titreSlug,
    this.imagePreview,
    this.imageUrl,
    this.video,
    this.videoUrl,
    this.miniDescription,
    this.attente,
    this.duree,
    this.status,
    this.dateAdd,
    this.dateUpd,
    this.auteur,
    this.categorie,
    this.concours,
    this.tague,
  });

  factory CategorieVideo.fromJson(Map<String, dynamic> json) => CategorieVideo(
    id: json["id"],
    videoCommentaire: List<dynamic>.from(json["video_commentaire"].map((x) => x)),
    vues: List<Vue>.from(json["vues"].map((x) => Vue.fromJson(x))),
    videoLike: List<dynamic>.from(json["video_like"].map((x) => x)),
    videoDislike: List<dynamic>.from(json["video_dislike"].map((x) => x)),
    resultatsVideo: List<dynamic>.from(json["resultats_video"].map((x) => x)),
    titre: json["titre"],
    titreSlug: json["titre_slug"],
    imagePreview: json["image_preview"],
    imageUrl: json["image_url"],
    video: json["video"],
    videoUrl: json["video_url"],
    miniDescription: json["mini_description"],
    attente: json["attente"],
    duree: json["duree"],
    status: json["status"],
    dateAdd: DateTime.parse(json["date_add"]),
    dateUpd: DateTime.parse(json["date_upd"]),
    auteur: Auteur.fromJson(json["auteur"]),
    categorie: Categorie.fromJson(json["categorie"]),
    concours: json["concours"],
    tague: List<dynamic>.from(json["tague"].map((x) => x)),
  );

}

class Categorie {
  int id;
  List<CategorieVideo> categorieVideo;
  String nom;
  String image;
  String description;
  String titreSlug;
  bool status;
  DateTime dateAdd;
  DateTime dateUpd;

  Categorie({
    this.id,
    this.categorieVideo,
    this.nom,
    this.image,
    this.description,
    this.titreSlug,
    this.status,
    this.dateAdd,
    this.dateUpd,
  });

  factory Categorie.fromJson(Map<String, dynamic> json) => Categorie(
    id: json["id"],
    categorieVideo: json["categorie_video"] == null ? null : List<CategorieVideo>.from(json["categorie_video"].map((x) => CategorieVideo.fromJson(x))),
    nom: json["nom"],
    image: json["image"],
    description: json["description"],
    titreSlug: json["titre_slug"],
    status: json["status"],
    dateAdd: DateTime.parse(json["date_add"]),
    dateUpd: DateTime.parse(json["date_upd"]),
  );

}

class Auteur {
  int id;
  String password;
  DateTime lastLogin;
  bool isSuperuser;
  String username;
  String firstName;
  String lastName;
  String email;
  bool isStaff;
  bool isActive;
  DateTime dateJoined;
  List<dynamic> groups;
  List<dynamic> userPermissions;

  Auteur({
    this.id,
    this.password,
    this.lastLogin,
    this.isSuperuser,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.isStaff,
    this.isActive,
    this.dateJoined,
    this.groups,
    this.userPermissions,
  });

  factory Auteur.fromJson(Map<String, dynamic> json) => Auteur(
    id: json["id"],
    password: json["password"],
    lastLogin: DateTime.parse(json["last_login"]),
    isSuperuser: json["is_superuser"],
    username: json["username"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    isStaff: json["is_staff"],
    isActive: json["is_active"],
    dateJoined: DateTime.parse(json["date_joined"]),
    groups: List<dynamic>.from(json["groups"].map((x) => x)),
    userPermissions: List<dynamic>.from(json["user_permissions"].map((x) => x)),
  );

}

class Vue {
  int id;
  String ip;
  String longitude;
  String latitude;
  bool status;
  DateTime dateAdd;
  DateTime dateUpd;
  Video video;
  Auteur user;

  Vue({
    this.id,
    this.ip,
    this.longitude,
    this.latitude,
    this.status,
    this.dateAdd,
    this.dateUpd,
    this.video,
    this.user,
  });

  factory Vue.fromJson(Map<String, dynamic> json) => Vue(
    id: json["id"],
    ip: json["ip"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    status: json["status"],
    dateAdd: DateTime.parse(json["date_add"]),
    dateUpd: DateTime.parse(json["date_upd"]),
    video: Video.fromJson(json["video"]),
    user: json["user"] == null ? null : Auteur.fromJson(json["user"]),
  );


}



class Video {
  int id;
  String titre;
  String titreSlug;
  dynamic imagePreview;
  String imageUrl;
  dynamic video;
  String videoUrl;
  String miniDescription;
  bool attente;
  String duree;
  bool status;
  DateTime dateAdd;
  DateTime dateUpd;
  int auteur;
  int categorie;
  dynamic concours;
  List<dynamic> tague;

  Video({
    this.id,
    this.titre,
    this.titreSlug,
    this.imagePreview,
    this.imageUrl,
    this.video,
    this.videoUrl,
    this.miniDescription,
    this.attente,
    this.duree,
    this.status,
    this.dateAdd,
    this.dateUpd,
    this.auteur,
    this.categorie,
    this.concours,
    this.tague,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    id: json["id"],
    titre: json["titre"],
    titreSlug: json["titre_slug"],
    imagePreview: json["image_preview"],
    imageUrl: json["image_url"],
    video: json["video"],
    videoUrl: json["video_url"],
    miniDescription: json["mini_description"],
    attente: json["attente"],
    duree: json["duree"],
    status: json["status"],
    dateAdd: DateTime.parse(json["date_add"]),
    dateUpd: DateTime.parse(json["date_upd"]),
    auteur: json["auteur"],
    categorie: json["categorie"],
    concours: json["concours"],
    tague: List<dynamic>.from(json["tague"].map((x) => x)),
  );

}
