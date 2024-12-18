import 'package:flutter/material.dart';

class Lengkap extends StatefulWidget {
  const Lengkap({super.key, required this.longText});
  final String longText;
  @override
  State<Lengkap> createState() => _LengkapState();
}

class _LengkapState extends State<Lengkap> {
  bool readMore = false;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          widget.longText,
          style: TextStyle(fontSize: 14,
          fontWeight: FontWeight.w400,color: Theme.of(context).primaryColor,
          ),
          maxLines: readMore ? 1000 : 5,
          overflow: TextOverflow.ellipsis,
        ),
        TextButton(onPressed: (){
          setState(() {
            readMore = !readMore;
          });
        }, child: Text(readMore ? 'Read less' : 'Read more'),
        ),
      ],
    );
  }
}