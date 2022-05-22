import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeHero extends StatelessWidget {
  const HomeHero({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color orange = Color(0xfffaaa55);

    return Container(
        width: 400,
        height: 180,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: orange,
          //borderRadius: BorderRadius.circular(15)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: const Text(
                    "Process Monitoring",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 15),
                    width: 200,
                    child: const Text(
                      "Track, measure and monitor entire process, purchase to dispatch and form production to management level",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      maxLines: 5,
                    ))
              ],
            ),
            Container(
              decoration: BoxDecoration(color: orange),
              width: 150,
              child: Image.asset(
                'assets/images/heroImg1.png',
                fit: BoxFit.cover,
              ),
            )
          ],
        ));
  }
}
