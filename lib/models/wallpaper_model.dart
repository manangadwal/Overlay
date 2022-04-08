class Wallpapermodel {
  String? photographer;
  String? photographer_url;
  int? photographer_id;
  SrcModel? src;

  Wallpapermodel(
      {this.photographer,
      this.photographer_id,
      this.photographer_url,
      this.src});

  factory Wallpapermodel.fromMap(Map<String, dynamic> jsonData) {
    return Wallpapermodel(
        src: SrcModel.fromMap(jsonData["src"]),
        photographer: jsonData["photographer"],
        photographer_id: jsonData["photographer_id"],
        photographer_url: jsonData["photographer_url"]);
  }
}

class SrcModel {
  String? original;
  String? small;
  String? portrait;

  SrcModel({this.original, this.portrait, this.small});

  factory SrcModel.fromMap(Map<String, dynamic> jsonData) {
    return SrcModel(
      portrait: jsonData["portrait"],
      original: jsonData["original"],
      small: jsonData["small"],
    );
  }
}
