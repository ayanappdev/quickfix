// import 'package:flutter/material.dart';

// class MapBottomSheet extends StatelessWidget {
//   const MapBottomSheet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DraggableScrollableSheet(
//     initialChildSize: 0.1, // Initial height of the bottom sheet when closed (10% of screen)
//     minChildSize: 0.1, // Minimum height when sliding to close
//     maxChildSize: 0.95, // Maximum height when fully expanded
//     builder: (BuildContext context, ScrollController scrollController) {
//       return Container(
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 10,
//               offset: Offset(0, -2),
//             ),
//           ],
//         ),
//         child: SingleChildScrollView(
//           controller: scrollController,
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               GestureDetector(
//                 behavior: HitTestBehavior.opaque,
//                 onTap: () {
//                   // Toggle between fully closed and partially open
//                   if (scrollController.position.viewportDimension <
//                       MediaQuery.of(context).size.height * 0.95) {
//                     scrollController.animateTo(
//                       MediaQuery.of(context).size.height * 0.95,
//                       duration: const Duration(milliseconds: 500),
//                       curve: Curves.easeOut,
//                     );
//                   } else {
//                     scrollController.animateTo(
//                       MediaQuery.of(context).size.height * 0.1,
//                       duration: const Duration(milliseconds: 500),
//                       curve: Curves.easeOut,
//                     );
//                   }
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         width: 40,
//                         height: 5,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[400],
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(16, 16, 16, 0), // Adjust top padding
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 12),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               const Icon(Icons.timer, color: Colors.green, size: 24),
//                               const SizedBox(width: 8),
//                               Text(
//                                 'ETA: ${formatDuration(durationInSeconds)}',
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: <Widget>[
//                               const Icon(Icons.directions, color: Colors.green, size: 24),
//                               const SizedBox(width: 8),
//                               Text(
//                                 '${formatDistance(distanceInMeters)}',
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     const Divider(color: Colors.grey[400]), // Add a divider for separation
                    
//                     // Shop Name
//                     const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 12),
//                       child: Row(
//                         children: <Widget>[
//                           Icon(Icons.store, color: Colors.green, size: 24),
//                           SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               'Shop Name',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.black87,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
                    
//                     // Mechanic Name
//                     const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 12),
//                       child: Row(
//                         children: <Widget>[
//                           Icon(Icons.person, color: Colors.green, size: 24),
//                           SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               'Mechanic Name',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.black87,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
                    
//                     // Location
//                     const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 12),
//                       child: Row(
//                         children: <Widget>[
//                           Icon(Icons.location_on, color: Colors.green, size: 24),
//                           SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               '123 Main Street, City Name',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.black87,
//                               ),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
                    
//                     // Phone Number
//                     const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 12),
//                       child: Row(
//                         children: <Widget>[
//                           Icon(Icons.phone, color: Colors.green, size: 24),
//                           SizedBox(width: 8),
//                           Text(
//                             '+1234567890',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black87,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
                    
//                     // Request Button
//                     Container(
//                       width: double.infinity,
//                       margin: const EdgeInsets.symmetric(vertical: 16),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Handle button press
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.green,
//                           padding: const EdgeInsets.all(16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: const Text(
//                           'Request Service',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
                    
//                     // Add more custom information as needed
                    
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
//   }
// }