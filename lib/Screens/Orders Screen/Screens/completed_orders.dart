import 'package:flutter/material.dart';

class CompletedOrderScreen extends StatelessWidget {
  const CompletedOrderScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text("completed")],
      ),
    );
  }
}
