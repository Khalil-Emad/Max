import 'package:max/constants/constants.dart';
import 'package:max/widgets/header.dart';
import 'package:max/widgets/responsive.dart';
import 'package:flutter/material.dart';
import '../../widgets/transactionScreen.dart';

class DashbordScreen extends StatelessWidget {
  const DashbordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: Header(),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        TransactionScreen(),
                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                        // if (Responsive.isMobile(context)) StorageDetails(),
                      ],
                    ),
                  ),
                  // if (!Responsive.isMobile(context))
                  //   SizedBox(width: defaultPadding),
                  // if (!Responsive.isMobile(context))
                  //   Expanded(
                  //     flex: 2,
                  //     child: StorageDetails(),
                  //   ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
