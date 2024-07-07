import 'package:flutter/material.dart';
import 'package:quickfix/Screens/Orders%20Screen/Components/indicator_widget.dart';
import 'package:quickfix/Screens/Orders%20Screen/Components/profile_indicator_widget.dart';
import 'package:quickfix/Screens/Orders%20Screen/Screens/completed_orders.dart';
import 'package:quickfix/Screens/Orders%20Screen/Screens/requested_orders.dart';
import 'package:quickfix/Screens/Orders%20Screen/Screens/under_processing_orders.dart';


class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SizedBox(height: 15,),
            ProfileIndicatorsWidget(
              children: [
                IndicatorWidget(
                  onTap: () {
                    pageController.jumpToPage(0);
                    setState(() => currentPage = 0);
                  },
                  isSelected: currentPage == 0,
                  title: "Requested",
                ),
                IndicatorWidget(
                  onTap: () {
                    pageController.jumpToPage(1);
                    setState(() => currentPage = 1);
                  },
                  isSelected: currentPage == 1,
                  title: "Processing",
                ),
                IndicatorWidget(
                  onTap: () {
                    pageController.jumpToPage(2);
                    setState(() => currentPage = 2);
                  },
                  isSelected: currentPage == 2,
                  title: "Completed",
                ),
              ],
            ),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                onPageChanged: (value) => currentPage = value,
                children: const [
                  RequestedOrderScreen(),
                  UnderProcessingOrderScreen(),
                  CompletedOrderScreen()
                ],
              ),
            ),
          ],
        ),
      ),
   
    );
  }
}
