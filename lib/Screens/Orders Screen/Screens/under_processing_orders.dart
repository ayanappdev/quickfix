import 'package:flutter/material.dart';

class UnderProcessingOrderScreen extends StatelessWidget {
  const UnderProcessingOrderScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text("underprocessing")],
      ),
    );
  }
}
