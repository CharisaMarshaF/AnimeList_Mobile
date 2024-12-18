import 'package:flutter/material.dart';

class OpenImage extends StatelessWidget {
  const OpenImage({super.key, required this.imageUrl,});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.network(imageUrl,fit: BoxFit.cover,),),
    );
  }
}