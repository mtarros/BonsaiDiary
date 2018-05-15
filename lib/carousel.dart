import 'package:flutter/material.dart';
import 'package:matcher/matcher.dart';


class Carousel extends StatefulWidget {
  @override
  _CarouselState createState() => new _CarouselState();
}

class _CarouselState extends State<Carousel> {
  PageController controller;
  int currentpage = 0;

  @override
  initState() {
    super.initState();
    controller = new PageController(
      initialPage: currentpage,
      keepPage: false,
      viewportFraction: 1.0,
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: new Container(
        color: Colors.transparent,
        child: new PageView.builder(
            onPageChanged: (value) {
              setState(() {
                currentpage = value;
              });
            },
            controller: controller,
            itemBuilder: (context, index) => builder(index)),
      ),
    );
  }

  builder(int index) {

    return new Card(elevation: 5.0, color: Colors.red,
      child: new Image.network('https://pbs.twimg.com/media/DZT32WYXcAApSkd.jpg',
        fit: BoxFit.fitWidth)
    );
//    return new AnimatedBuilder(
//      animation: controller,
//      builder: (context, child) {
//
//        double value = 0.5;
//
//        try
//        {
//           var page = controller.page;
//           value = page - index;
//        }
//        catch(e, stack) {
//
//
//        }
//
//
//        value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);
//
//        return new Center(
//          child: new SizedBox(
//            height: Curves.easeOut.transform(value) * 300,
//            width: Curves.easeOut.transform(value) * 250,
//            child: child,
//          ),
//        );
//      },
//      child: new Container(
//        margin: const EdgeInsets.all(28.0),
//        color: index % 2 == 0 ? Colors.blue : Colors.red,
//      ),
//    );
  }
}