import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class GlowCircle extends StatefulWidget {
  const GlowCircle({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GlowCircle();
  }
}

class _GlowCircle extends State<GlowCircle>
    with SingleTickerProviderStateMixin {
  //use "with SingleThickerProviderStateMixin" at last of class declaration
  //where you have to pass "vsync" argument, add this

  late Animation<double> animation; //animation variable for circle 1
  late AnimationController
      animationcontroller; //animation controller variable circle 1

  @override
  void initState() {
    animationcontroller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    //here we have to vash vsync argument, there for we use "with SingleTickerProviderStateMixin" above
    //vsync is the ThickerProvider, and set duration of animation

    animationcontroller.repeat();
    //repeat the animation controller

    animation = Tween<double>(begin: 0, end: 800).animate(animationcontroller);
    //set the begin value and end value, we will use this value for height and width of circle

    animation.addListener(() {
      setState(() {});
      //set animation listiner and set state to update UI on every animation value change
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    animationcontroller.dispose(); //destory anmiation to free memory on last
  }

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
            title: const Text("Simple Concept of Animation"),
            backgroundColor: Colors.redAccent),
        body: Container(
            width: sizeX,
            height: sizeY,
            child: Stack(
              //fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, //making box to circle
                      color: Colors.purple
                          .withOpacity(0.5) //background of container
                      ),
                  height: animation.value, //value from animation controller
                  width: animation.value, //value from animation controller
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, //making box to circle
                    color:
                        Colors.amber.withOpacity(0.5), //background of container
                  ),
                  height: 60.0 * (3 - 0), //value from animation controller
                  width: 60.0 * (3 - 0), //value from animation controller
                ),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, //making box to circle
                      color: Colors.deepOrangeAccent
                          .withOpacity(0.5) //background of container
                      ),
                  height: 60.0, //value from animation controller
                  width: 60.0, //value from animation controller
                )
              ],
            )));
  }
}
