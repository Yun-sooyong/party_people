// import 'dart:convert';
// import 'dart:math';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class Bubbles extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _BubblesState();
//   }
// }

// class _BubblesState extends State<Bubbles> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late List<Bubble> bubbles;
//   final int numberOfBubbles = 200;
//   final Color color = Colors.amber;
//   final double maxBubbleSize = 10.0;

//   @override
//   void initState() {
//     super.initState();

//     // Initialize bubbles
//     bubbles = [];
//     int i = numberOfBubbles;
//     while (i > 0) {
//       bubbles.add(Bubble(color, maxBubbleSize));
//       i--;
//     }

//     // Init animation controller
//     _controller = new AnimationController(
//         duration: const Duration(seconds: 1000), vsync: this);
//     _controller.addListener(() {
//       updateBubblePosition();
//     });
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomPaint(
//         foregroundPainter:
//             BubblePainter(bubbles: bubbles, controller: _controller),
//         size: Size(MediaQuery.of(context).size.width,
//             MediaQuery.of(context).size.height),
//       ),
//     );
//   }

//   void updateBubblePosition() {
//     bubbles.forEach((it) => it.updatePosition());
//     setState(() {});
//   }
// }

// class BubblePainter extends CustomPainter {
//   List<Bubble> bubbles;
//   AnimationController controller;

//   BubblePainter({required this.bubbles, required this.controller});

//   @override
//   void paint(Canvas canvas, Size canvasSize) {
//     bubbles.forEach((it) => it.draw(canvas, canvasSize));
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }

// class Bubble {
//   Color colour;
//   late double direction;
//   late double speed;
//   late double radius;
//   late double x;
//   late double y;

//   Bubble({
//     this.colour = colour.withOpacity(Random().nextDouble());
//     this.direction = Random().nextDouble() * 360;
//     this.speed = 1;
//     this.radius = Random().nextDouble() * maxBubbleSize;
//     maxBubbleSize,
//   }) 

//   // Bubble(Color colour, double maxBubbleSize) {
//   //   this.colour = colour.withOpacity(Random().nextDouble());
//   //   this.direction = Random().nextDouble() * 360;
//   //   this.speed = 1;
//   //   this.radius = Random().nextDouble() * maxBubbleSize;
//   // }

//   draw(Canvas canvas, Size canvasSize) {
//     Paint paint = new Paint()
//       ..color = colour
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.fill;

//     assignRandomPositionIfUninitialized(canvasSize);

//     randomlyChangeDirectionIfEdgeReached(canvasSize);

//     canvas.drawCircle(Offset(x, y), radius, paint);
//   }

//   void assignRandomPositionIfUninitialized(Size canvasSize) {
//     if (x == null) {
//       this.x = Random().nextDouble() * canvasSize.width;
//     }

//     if (y == null) {
//       this.y = Random().nextDouble() * canvasSize.height;
//     }
//   }

//   updatePosition() {
//     var a = 180 - (direction + 90);
//     direction > 0 && direction < 180
//         ? x += speed * sin(direction) / sin(speed)
//         : x -= speed * sin(direction) / sin(speed);
//     direction > 90 && direction < 270
//         ? y += speed * sin(a) / sin(speed)
//         : y -= speed * sin(a) / sin(speed);
//   }

//   randomlyChangeDirectionIfEdgeReached(Size canvasSize) {
//     if (x > canvasSize.width || x < 0 || y > canvasSize.height || y < 0) {
//       direction = Random().nextDouble() * 360;
//     }
//   }

//   Bubble copyWith({
//     Color? colour,
//     double? direction,
//     double? speed,
//     double? radius,
//     double? x,
//     double? y,
//   }) {
//     return Bubble(
//       colour: colour ?? this.colour,
//       direction: direction ?? this.direction,
//       speed: speed ?? this.speed,
//       radius: radius ?? this.radius,
//       x: x ?? this.x,
//       y: y ?? this.y,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'colour': colour.value,
//       'direction': direction,
//       'speed': speed,
//       'radius': radius,
//       'x': x,
//       'y': y,
//     };
//   }

//   factory Bubble.fromMap(Map<String, dynamic> map) {
//     return Bubble(
//       colour: Color(map['colour']),
//       direction: map['direction']?.toDouble() ?? 0.0,
//       speed: map['speed']?.toDouble() ?? 0.0,
//       radius: map['radius']?.toDouble() ?? 0.0,
//       x: map['x']?.toDouble() ?? 0.0,
//       y: map['y']?.toDouble() ?? 0.0,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Bubble.fromJson(String source) => Bubble.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'Bubble(colour: $colour, direction: $direction, speed: $speed, radius: $radius, x: $x, y: $y)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is Bubble &&
//         other.colour == colour &&
//         other.direction == direction &&
//         other.speed == speed &&
//         other.radius == radius &&
//         other.x == x &&
//         other.y == y;
//   }

//   @override
//   int get hashCode {
//     return colour.hashCode ^
//         direction.hashCode ^
//         speed.hashCode ^
//         radius.hashCode ^
//         x.hashCode ^
//         y.hashCode;
//   }
// }
