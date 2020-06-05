import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomDrawer extends StatefulWidget {
  final double elevation;
  final Widget child;
  final String semanticLabel;
  final double widthPercent;

  final DrawerCallback callback;

  const CustomDrawer({
    Key key,
    this.elevation = 16.0,
    this.child,
    this.semanticLabel,
    ///默认Drawer宽度占屏幕宽度百分比
    this.widthPercent = 0.55,

    this.callback,

  })  : assert(widthPercent < 1.0 && widthPercent > 0.0),
        super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();


}

class _CustomDrawerState extends State<CustomDrawer> {

  @override
  ///Drawer出现在屏幕时会回调initState()
  void initState() {
    if(widget.callback!=null){
      widget.callback(true);
    }
    super.initState();
  }


  @override
  ///Drawer完全消失在屏幕外时回调dispose()
  void dispose() {
    if(widget.callback!=null){
      widget.callback(false);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    String label = widget.semanticLabel;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        label = widget.semanticLabel;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        label = widget.semanticLabel ?? MaterialLocalizations.of(context)?.drawerLabel;
    }
    final double _width = MediaQuery.of(context).size.width * widget.widthPercent;
    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      label: label,
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(width: _width),
        child: Material(
          elevation: widget.elevation,
          child: widget.child,
        ),
      ),
    );
  }
}