import 'package:flutter/material.dart';

///  BadgeWidget 小红点控件
///  由两部分控件组成: 中间控件 + 右上角/其他位置的红点显示(注:红点数据支持异步加载)
///
/// BadgeWidget(
///   future: GiteeApi().notificationCount(true),
///   centerIconData: Icons.notifications_none,
///   smallTextBgColor: Colors.red,
///   smallTextMarginRight: 12,
///   smallTextMarginTop: 12,
///   onPressed: () { ... },
/// ),
class BadgeWidget<T> extends StatefulWidget {
  BadgeWidget({
    Key key,
    this.future,
    this.centerWidget,
    this.centerIconData,
    this.smallText,
    this.smallTextStyle,
    this.smallTextBgColor,
    this.smallTextPadding,
    this.onPressed,
    this.smallTextMarginLeft,
    this.smallTextMarginTop,
    this.smallTextMarginRight,
    this.smallTextMarginBottom,
  }) : super(key: key);

  final Future<T> future;
  final GestureTapCallback onPressed;
  final Widget centerWidget;
  final IconData centerIconData;
  final int smallText;
  final TextStyle smallTextStyle;
  final Color smallTextBgColor;
  final EdgeInsetsGeometry smallTextPadding;

  //红点距离边界位置,默认右上角
  final double smallTextMarginLeft, smallTextMarginTop, smallTextMarginRight, smallTextMarginBottom;

  @override
  _BadgeWidgetState createState() {
    return _BadgeWidgetState();
  }
}

class _BadgeWidgetState extends State<BadgeWidget> {
  @override
  void initState() {
    super.initState();
    //centerWidget,centerIconData至少设置了一个
    if (widget.centerWidget == null && widget.centerIconData == null) {
      throw ('centerWidget,centerIconData至少设置了一个');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.passthrough,
      children: [
        Center(
          child: widget.centerWidget ??
              IconButton(
                icon: Icon(widget.centerIconData),
                onPressed: widget.onPressed,
              ),
        ),
        Positioned(
          left: widget.smallTextMarginLeft,
          top: widget.smallTextMarginTop,
          right: widget.smallTextMarginRight,
          bottom: widget.smallTextMarginBottom,
          child: ClipOval(
            child: Container(
                color: widget.smallTextBgColor ?? Colors.red,
                child: Center(
                  child: Padding(
                    padding: widget.smallTextPadding ?? EdgeInsets.all(2.2),
                    child: _buildNumber(),
                  ),
                )),
          ),

          //smallTextNum
        ),
      ],
    );
  }

  Widget _buildNumber() {
    final bool isAsync = (widget.future != null) ?? false;
    if (isAsync) {
      return FutureBuilder<String>(
        future: widget.future,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Text(
              snapshot.data ?? "",
              style: _numberTextStyle(),
            );
          }
          return Container(width: 0, height: 0);
        },
      );
    } else {
      return Text(
        widget?.smallText?.toString() ?? "",
        style: _numberTextStyle(),
      );
    }
  }

  TextStyle _numberTextStyle() =>
      widget.smallTextStyle ??
      TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 8,
      );
}
