import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LiveCommentUserImage extends StatefulWidget {
  final String? image;
  final String name;
  const LiveCommentUserImage({super.key, this.image, required this.name});

  @override
  State<LiveCommentUserImage> createState() => _LiveCommentUserImageState();
}

class _LiveCommentUserImageState extends State<LiveCommentUserImage> {
  @override
  Widget build(BuildContext context) {
    final bgColors = [
      Colors.purple,
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.indigo,
      Colors.deepPurple,
      Colors.deepOrange,
      Colors.teal,
      Colors.cyan,
      Colors.pink,
      Colors.brown,
      Colors.amber.shade800,
      Colors.blueGrey,
      Colors.lime.shade800,
      Colors.grey.shade800,
      Colors.green.shade800,
      Colors.red.shade900,
      Colors.blue.shade900,
    ];
    final imgWidth= 30.w;
    final imgHeight= 30.w;
    return widget.image!=null?
    Container(
        height: imgHeight,
        width: imgWidth,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(widget.image!),
                fit: BoxFit.fill
            )
        ),
    ):
    Container(
      height: imgHeight,
      width: imgWidth,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _getAvatarColor(widget.name)
      ),
      child: Center(child: Text(widget.name[0].toUpperCase(),style: TextStyle(fontSize: 14.sp< 30.w? 14.sp: 10.sp),)),
    )
    ;
  }

  final avatarBgColors = [
    Color(0xFFEF5350), // Red
    Color(0xFFAB47BC), // Purple
    Color(0xFF5C6BC0), // Indigo
    Color(0xFF29B6F6), // Light Blue
    Color(0xFF26A69A), // Teal
    Color(0xFF66BB6A), // Green
    Color(0xFFFFA726), // Orange
    Color(0xFFFF7043), // Deep Orange
    Color(0xFF8D6E63), // Brown
    Color(0xFF78909C), // Blue Grey
  ];

  Color _getAvatarColor(String input) {
    final colors = avatarBgColors;
    final index = input.codeUnits.fold(0, (prev, elem) => prev + elem) % colors.length;
    return colors[index];
  }
}
