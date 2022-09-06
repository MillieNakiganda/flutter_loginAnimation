import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class Planets3 extends StatefulWidget {
  const Planets3({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Planets3State createState() => _Planets3State();
}

class _Planets3State extends State<Planets3> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controller1;
  late Size size;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _controller1 = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: const Duration(seconds: 5),
    )..repeat();

    _controller.reset();
    _controller.repeat();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0XffFEFEFE), //
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: AnimatedContainer(
        color: Colors.white,
        duration: const Duration(milliseconds: 300),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 150, 500, 10),
              child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, snapshot) {
                    return CustomPaint(
                      painter: AtomPaint(
                        value: _controller.value,
                      ),
                    );
                  }),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Transform.translate(
                offset: const Offset(-160, 360),
                child: _buildSun(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSun() {
    return AnimatedBuilder(
      animation: CurvedAnimation(parent: _controller1, curve: Curves.bounceOut),
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _buildContainer(1000 * _controller1.value),
            _buildContainer(1200 * _controller1.value),
            _buildContainer(1400 * _controller1.value),
          ],
        );
      },
    );
  }

  Widget _buildContainer(double radius) {
    return CustomPaint(
      size: Size(radius, radius),
      painter: CirclePainter(),
    );
  }
}

class CirclePainter extends CustomPainter {
  var wavePaint = Paint()
    ..color = const Color(0xff0D2C5E).withOpacity(0.5)
    ..style = PaintingStyle.fill
    ..strokeWidth = 2.0
    ..isAntiAlias = true;
  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    canvas.drawCircle(Offset(centerX, centerY), 300.0, wavePaint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return false;
  }
}

class AtomPaint extends CustomPainter {
  AtomPaint({
    required this.value,
  });

  final double value;

  final Paint _axisPaint = Paint()
    ..color = const ui.Color(0xff4275BB).withOpacity(0.5)
    ..strokeWidth = 2.0
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    drawAxis(value, canvas, 200,
        Paint()..color = const ui.Color(0xffFCA400).withOpacity(0.5));
  }

  drawAxis(double value, Canvas canvas, double radius, Paint paint) {
    var firstAxis = getCirclePath(radius);
    canvas.drawPath(firstAxis, _axisPaint);
    ui.PathMetrics pathMetrics = firstAxis.computeMetrics();
    for (ui.PathMetric pathMetric in pathMetrics) {
      Path extractPath = pathMetric.extractPath(
        0.0,
        pathMetric.length * value,
      );
      try {
        var metric = extractPath.computeMetrics().first;
        final offset = metric.getTangentForOffset(metric.length)?.position;
        canvas.drawCircle(offset!, 20.0, paint);
      } catch (e) {}
    }
  }

  Path getCirclePath(double radius) => Path()
    ..addOval(Rect.fromCircle(center: const Offset(0, 0), radius: radius));

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
