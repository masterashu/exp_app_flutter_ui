import 'package:flutter/material.dart';

class MultipleAvatar extends StatelessWidget {
  final List<String> images;
  final double size;
  final double border;
  MultipleAvatar(this.images, {this.size = 40, this.border = 10, key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> avatars = [];
    for (int i = (images.length > 3) ? 3 : images.length - 1; i >= 0; i--) {
      avatars.add(Positioned(
        top: 0,
        left: i * (size * 5 / 8),
        child: Container(
          width: size,
          height: size,
          padding: EdgeInsets.all(border),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size), color: Colors.white),
          child: ClipOval(
              child: Image.asset(
            images[i],
            width: size - 2,
            height: size - 2,
          )),
        ),
      ));
    }
    if (avatars.length > 3)
      avatars.add(Positioned(
          child: Container(
        child: Container(
          padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: Text(
            "+${avatars.length - 3}",
            style: TextStyle(
              color: Color.fromARGB(255, 108, 99, 255),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        ),
      )));
    return Container(
      margin: EdgeInsets.all(8),
      height: size + border,
      child: Stack(
        children: <Widget>[...avatars],
      ),
    );
  }
}
