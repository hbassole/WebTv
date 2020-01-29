class Vue {
  int id;
  String ip;
  String country;
  String city;
  String reseau;
  int video;
  int user;

  Vue({
    this.id,
    this.ip,
    this.country,
    this.city,
    this.reseau,
    this.video,
    this.user,
  });

  factory Vue.fromJson(Map<String, dynamic> json) => Vue(
    id: json["id"],
    ip: json["ip"],
    country: json["country"],
    city: json["city"],
    reseau: json["reseau"],
    video: json["video"],
    user: json["user"],
  );
}
