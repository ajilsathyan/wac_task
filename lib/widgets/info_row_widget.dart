import 'package:flutter/material.dart';

class InfoRowWidget extends StatelessWidget {
  IconData icon;
  String info;
  Color color;
  InfoRowWidget(
      {Key? key, required this.icon, required this.info, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
          ),
          SizedBox(
            width: 10,
          ),
          Text(info),
        ],
      ),
    );
  }
}
