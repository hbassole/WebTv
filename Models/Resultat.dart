class Resultat {
  final int id ;
  Resultat({this.id});

  factory Resultat.fromJson(Map<String, dynamic>json){
    return Resultat(
      id: json["id"],
    );
  }

}