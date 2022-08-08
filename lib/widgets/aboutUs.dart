import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';
import 'package:max/constants/constants.dart';
import 'package:max/widgets/header.dart';

class AboutUs extends StatefulWidget {
  AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 70, left: 70),
                          child: ContactUs(
                            logo: AssetImage('assets/images/logo.png'),
                            email: 'khalilemad26@outlook.com',
                            companyName: 'Code Root',
                            phoneNumber: '+201122700297',
                            dividerThickness: 2,
                            facebookHandle: 'khalil.emad.9',
                            cardColor: Colors.white54,
                            companyColor: Colors.yellowAccent.shade400,
                            taglineColor: Colors.black,
                            textColor: Colors.black,
                            avatarRadius: 80,
                            phoneNumberText: "+201122700297",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
