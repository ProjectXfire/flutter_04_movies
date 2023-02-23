import 'package:flutter/material.dart';
// Models
import '../models/_models.dart';
// Helpers
import 'package:movies/shared/helpers/_helpers.dart';

class CardSlider extends StatefulWidget {
  CardSlider({super.key, this.title, required this.cardInfo, this.onScroll});

  final String? title;
  final List<SliderCardModel> cardInfo;
  final Function? onScroll;

  @override
  State<CardSlider> createState() => _CardSliderState();
}

class _CardSliderState extends State<CardSlider> {
  final ScrollController scrollController = ScrollController();
  bool flag = true;

  @override
  void initState() {
    super.initState();
    if (widget.onScroll != null) {
      scrollController.addListener(() {
        final pos = scrollController.position;
        if (pos.pixels.ceil() >= (pos.maxScrollExtent - 500).ceil() && flag) {
          setState(() {
            flag = false;
          });
          widget.onScroll!();
          Future.delayed(const Duration(milliseconds: 1000)).then((value) {
            setState(() {
              flag = true;
            });
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(widget.title!,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          Expanded(
            child: ListView.builder(
                controller: scrollController,
                itemCount: widget.cardInfo.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return _Card(
                    id: "slider-${widget.cardInfo[i].id}",
                    title: widget.cardInfo[i].title,
                    imagePath: widget.cardInfo[i].imagePath,
                    onTap: widget.cardInfo[i].onTap,
                  );
                }),
          )
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card(
      {required this.title,
      required this.imagePath,
      this.onTap,
      required this.id});

  final String id;
  final String title;
  final String? imagePath;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Hero(
              tag: id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  height: 150,
                  placeholder:
                      const AssetImage("lib/shared/assets/no-image.jpg"),
                  image: getValidOriginalImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 1),
            Text(title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
          ],
        ),
      ),
    );
  }
}
