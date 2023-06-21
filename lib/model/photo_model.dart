class PhotosModel {
  String imgSrc;
  String photoName;

  PhotosModel({required this.photoName, required this.imgSrc});

  static PhotosModel fromAPI2App(Map<String, dynamic> photoMap) {
    return PhotosModel(
        photoName: photoMap["photographer"],
        imgSrc: photoMap["src"]["portrait"]);
  }
}