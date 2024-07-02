import 'package:flutter/material.dart';

class RequestedOrderScreen extends StatelessWidget {
  const RequestedOrderScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text("requested")],
      ),
    );
  }
}
