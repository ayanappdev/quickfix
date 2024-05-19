import 'package:flutter/material.dart';

class HomeSlider extends StatelessWidget {
  final Function(int) onChange;
  final int currentSlide;
  const HomeSlider({
    super.key,
    required this.onChange,
    required this.currentSlide,
  });

  @override
  Widget build(BuildContext context) {
    // List of image paths
    final List<String> imagePaths = [
      "assets/images/img1.jpg",
      "assets/images/img2.jpg",
      "assets/images/img3.jpg",
      "assets/images/img4.jpg",
    ];

    return AspectRatio(
      aspectRatio:
          4 / 3, // Adjust this based on your image aspect ratio (800/600 = 4/3)
      child: Stack(
        children: [
          PageView.builder(
            onPageChanged: onChange,
            itemCount: imagePaths.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(imagePaths[index]),
                  ),
                ),
              );
            },
          ),
          Positioned.fill(
            bottom: 10,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  imagePaths.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: currentSlide == index ? 15 : 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: currentSlide == index
                          ? Color.fromARGB(255, 33, 144, 86)
                          : const Color.fromARGB(0, 202, 202, 202),
                      border: Border.all(
                          color: const Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class HomeSlider extends StatelessWidget {
//   final Function(int) onChange;
//   final int currentSlide;
//   const HomeSlider({
//     super.key,
//     required this.onChange,
//     required this.currentSlide,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         SizedBox(
//           height: 200,
//           width: double.infinity,
//           child: PageView.builder(
//             onPageChanged: onChange,
//             itemCount: 4,
//             itemBuilder: (context, index) {
//               return Container(
//                 height: 200,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   image: const DecorationImage(
//                     fit: BoxFit.fill,
//                     image: AssetImage("assets/images/slider.jpg"),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         Positioned.fill(
//           bottom: 10,
//           child: Align(
//             alignment: Alignment.bottomCenter,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(
//                 4,
//                 (index) => AnimatedContainer(
//                   duration: const Duration(milliseconds: 300),
//                   width: currentSlide == index ? 15 : 8,
//                   height: 8,
//                   margin: const EdgeInsets.only(right: 3),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: currentSlide == index
//                         ? Colors.black
//                         : Colors.transparent,
//                     border: Border.all(color: Colors.black),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
