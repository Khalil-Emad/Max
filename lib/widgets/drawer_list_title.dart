import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
   
    required this.title,
    required this.icon,
    required this.press,
  }) ;

  final String title;
  final IconData icon;

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0,
      selected: true,
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
