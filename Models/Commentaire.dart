class Commentaire {

  final int id;
  final int user;
  final String message;


  Commentaire({this.id, this.user, this.message });


  factory Commentaire.fromJson(Map<String, dynamic> json) => Commentaire(
    id: json["id"],
    message: json["message"],
    user: json["user"],
  );

}