class SliderCardModel {
  int id;
  String title;
  String? imagePath;
  void Function()? onTap;

  SliderCardModel(
      {required this.id,
      required this.title,
      required this.imagePath,
      this.onTap});
}
