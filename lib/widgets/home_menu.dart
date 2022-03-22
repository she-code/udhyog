import 'package:flutter/material.dart';

class HomeMenu extends StatelessWidget {
  final title;
  final img;
  final url;
  HomeMenu({required this.title, required this.img, required this.url});

  @override
  Widget build(BuildContext context) {
    Color green = Color(0xff074a2a);
    Color greenLight = Color(0xff63d47a);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(url);
      },
      child: Container(
        // width: 80,
        // height: 80,

        child: Column(
          children: [
            Container(
              width: 80,
              height: 60,
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                img,
                // fit: BoxFit.fitWidth,
                width: 20,
                height: 20,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3), //color of shadow
                    spreadRadius: 1, //spread radius
                    blurRadius: 10, // blur radius
                    offset: const Offset(1, 5), // changes position of shadow
                  ),
                ],
              ),
            ),
            Container(
                width: 75,
                // height: 60,
                alignment: Alignment.center,

                // child: Flexible(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 13, fontWeight: FontWeight.bold, color: green),
                  //),
                ))
          ],
        ),
      ),
    );

    // ));
  }
}
