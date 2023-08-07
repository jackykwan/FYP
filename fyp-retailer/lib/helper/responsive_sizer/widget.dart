part of responsive;

typedef ResponsiveBuilder = Widget Function(BuildContext context);

class Responsive extends StatelessWidget {
  const Responsive({super.key, required this.builder});
  final ResponsiveBuilder builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        ResponsiveUtil.setScreenSize(constraints, orientation);
        return builder(context);
      });
    });
  }
}
