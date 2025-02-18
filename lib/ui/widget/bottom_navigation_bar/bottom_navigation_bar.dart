import 'package:flutter/material.dart';
import 'package:todo_list/core/config/injector.dart';

import 'package:todo_list/layout/layout.dart';
import 'package:todo_list/ui/app_routes.dart';
import 'package:todo_list/ui/start_viewmodel.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({super.key});
  final StartViewModel startViewModel = injector.get<StartViewModel>();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final size = MediaQuery.of(context).size;
    final spacing = AppSpacing.of(context);
    return SizedBox(
      width: size.width,
      height: 80,
      child: Stack(
        // overflow: Overflow.visible,
        children: [
          CustomPaint(
            size: Size(size.width, 80),
            painter: _CustomPainter(colors: colors),
          ),
          Center(
            heightFactor: 0.3,
            child: FloatingActionButton(
                child: Icon(
                  Icons.add,
                  color: colors.cardBackground,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.addPost)),
          ),
          ListenableBuilder(
            listenable: startViewModel.routeEvent,
            builder: (context, _) {
              final route = startViewModel.routeEvent.rightResult;
              return SizedBox(
                width: size.width,
                height: 60,
                child: Padding(
                  padding: EdgeInsets.only(top: spacing.spacingXS),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spacing.spacingXXL,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.home,
                          size: 32,
                          color: route == AppRoutes.home
                              ? colors.primary
                              : colors.borderColor,
                        ),
                        onPressed: route == AppRoutes.home
                            ? null
                            : () => Navigator.popAndPushNamed(
                                context, AppRoutes.home),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.calendar_month_rounded,
                          size: 32,
                          color: route == AppRoutes.calendar
                              ? colors.primary
                              : colors.borderColor,
                        ),
                        onPressed: route == AppRoutes.calendar
                            ? null
                            : () => Navigator.popAndPushNamed(
                                context, AppRoutes.calendar),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CustomPainter extends CustomPainter {
  final AppColors colors;
  _CustomPainter({
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = colors.secondary
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 5);
    path.arcToPoint(Offset(size.width * 0.60, 5),
        radius: Radius.circular(1), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, colors.primary, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
