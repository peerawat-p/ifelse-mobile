
import 'package:flutter/widgets.dart';
import '../layer.dart';
import '../site.dart';
import '../convert/gradient.dart';
import '../convert/shadow.dart';
import '../convert/border.dart';
import '../convert/edge.dart';
import '../convert/util.dart';
import '../convert/editor.dart';

class DetailParser extends WidgetParser {
  @override
  Widget parse(String file, Map<String, dynamic> map, BuildContext buildContext, [Map<String, dynamic> par, Function func]) {
    dynamic box = getVal(map,'box'),
      data = getVal(map,'data');
    Color _color = getColor(getVal(data,'color'), '000');
    double _fSize = getDouble(getVal(data,'size') ?? Site.fontSize);
    return Container(
      decoration: BoxDecoration(
        gradient: getGradient(getVal(box,'bg.color')),
        borderRadius: getBorderRadius(getVal(box,'border')),
        boxShadow: getBoxShadow(getVal(box,'shadow')),
      ),
      margin: getEdgeInset(getVal(box,'margin')),
      //padding: getEdgeInset(getVal(box,'padding')),
      alignment: Alignment(0.0, 0.0),
      child: CustomPaint(
        //size: Size(viewportConstraints.maxWidth, viewportConstraints.maxHeight),
        painter: DrawCurve(getVal(box,'bg.color')),
        child: Container(
          padding: getEdgeInset(getVal(box,'padding')),
          child: Column(
            children: getEditor(par['editor'],_color,_fSize),
          )
        )
      )
    );
  }
  
  @override
  String get widgetName => 'detail';
}
