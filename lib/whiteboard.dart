import 'package:flutter/material.dart';

import 'appBars.dart';
import 'bottomNavigation.dart';

class SignaturePainter extends CustomPainter {
  SignaturePainter(this.points);

  final List<Offset> points;

  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null)
        canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  bool shouldRepaint(SignaturePainter other) => other.points != points;
}

class Signature extends StatefulWidget {
  SignatureState createState() => new SignatureState();
}

class SignatureState extends State<Signature> {
  List<Offset> _points = <Offset>[];

  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child:new Stack(
        children:[GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            RenderBox referenceBox = context.findRenderObject();
            Offset localPosition =
            referenceBox.globalToLocal(details.globalPosition);

            setState(() {
              _points = new List.from(_points)..add(localPosition);
            });
          },
          onPanEnd: (DragEndDetails details) => _points.add(null),
        ),
        CustomPaint(painter: new SignaturePainter(_points))],
      ),
    ),
      bottomNavigationBar:
        BottomNavigationBarApp(context, 1),
    );
  }
}

class WhiteBoard extends StatelessWidget {
  Widget build(BuildContext context) => new Scaffold(body: new Signature());
}
