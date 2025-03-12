import 'package:flutter/widgets.dart';
import 'package:flutter_map_marker_cluster_plus/src/map_widget.dart';
import 'package:flutter_map_marker_cluster_plus/src/rotate.dart';

class PositionedMapWidget extends MapWidget {
  final Size size;
  final Widget child;
  final Offset position;
  final Rotate? rotate;

  const PositionedMapWidget({
    required this.child,
    required this.size,
    required this.position,
    this.rotate,
    super.key,
  }) : super.withKey();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: size.width,
      height: size.height,
      left: position.dx,
      top: position.dy,
      child: rotate == null
          ? child
          : Transform.rotate(
              angle: rotate!.angle,
              alignment: (rotate!.alignment ?? Alignment.center) * -1,
              child: child,
            ),
    );
  }
}
