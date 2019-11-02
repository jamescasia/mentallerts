import 'package:flutter/material.dart';

class GradientIcon extends StatefulWidget {
  LinearGradient gradient;
  IconData icon;
  double size;
  // GradientIcon(this.icon, this.gradient, this.size);
  GradientIcon({
    Key key,
    @required this.icon,
    @required this.gradient,
    @required this.size,
  }) : super(key: key);
  @override
  _GradientIconState createState() => _GradientIconState(icon, gradient, size);
}

class _GradientIconState extends State<GradientIcon> {
  LinearGradient gradient;
  IconData icon;
  double size;
  _GradientIconState(this.icon, this.gradient, this.size);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return gradient.createShader(bounds);
      },
      child: Icon(
        icon,
        size: size,
      ),
    );
  }
}
