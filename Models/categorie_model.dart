

class CategorieModel{
  final String nom;
  final List<Video> videos;

  CategorieModel({this.nom, this.videos});

}


class Video{
  final String nom;
  final String path;

  Video({this.nom, this.path});
}