import 'package:flutter/material.dart';

class BackgroundBodyWidget extends StatelessWidget {
  const BackgroundBodyWidget(
      {super.key,
      required this.child,
      required this.imageName,
      this.imageScale,
      this.opacity});

  final Widget child;
  final String imageName;
  final BoxFit? imageScale;
  final double? opacity;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
              opacity: opacity ?? 0.6,
              image: AssetImage("assets/images/$imageName"),
              fit: imageScale ?? BoxFit.cover),
        ),
        child: child);
  }
}
