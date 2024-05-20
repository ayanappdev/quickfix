import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  final Function(int) onChange;
  final int currentImage;
  final List<String> imagePaths; // List of image paths
  const ImageSlider({
    Key? key,
    required this.onChange,
    required this.currentImage,
    required this.imagePaths,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        itemCount: imagePaths.length, // Set the number of images
        onPageChanged: onChange,
        itemBuilder: (context, index) {
          return Image.asset(imagePaths[index]); // Display each image
        },
      ),
    );
  }
}


















// import 'package:flutter/cupertino.dart';

// class ImageSlider extends StatelessWidget {
//   final Function(int) onChange;
//   final int currentImage;
//   final String image;
//   const ImageSlider({
//     super.key,
//     required this.onChange,
//     required this.currentImage,
//     required this.image,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 250,
//       child: PageView.builder(
//         itemCount: 5,
//         onPageChanged: onChange,
//         itemBuilder: (context, index) {
//           return Image.asset(image);
//         },
//       ),
//     );
//   }
// }
