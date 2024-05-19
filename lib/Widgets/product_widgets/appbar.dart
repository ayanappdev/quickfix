import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ProductAppBar extends StatelessWidget {
  const ProductAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: IconButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 45, 131, 95),
              padding: const EdgeInsets.all(10),
            ),
            icon: const Icon(
              Ionicons.chevron_back,
              color: Colors.white,
              size: 25,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            style: IconButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 45, 131, 95),
              padding: const EdgeInsets.all(10),
            ),
            iconSize: 25,
            icon: const Icon(
              Ionicons.cart_outline,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
