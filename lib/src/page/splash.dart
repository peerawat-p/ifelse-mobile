import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../site.dart';
import '../layer.dart';
import '../page/home.dart';
import '../convert/api.dart';
import '../convert/dialog.dart';
import '../convert/session.dart';
import '../convert/cache.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key, this.par}) : super(key: key);
  final Map<String, dynamic> par;

  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<SplashPage> {
  @override
  void initState() {
    sessionLoad();
    super.initState();    
  }

  Future<Widget> loadSplash() async {
    List<dynamic> template = await cacheGetList('template-splash');
    if((template != null) && (template is List) && (template.length > 0)) {
      Site.template['splash'] = template;
    }
    return Layer.buildContent('splash', context, null, null);
  }

  loadData() async {
    String message = '';
    if(await Api.load()) {  
      return Timer(Duration(seconds: 1),() {
        Get.offAll(HomePage());
      });
    } else {
      message = 'รหัส Token ไม่ถูกต้อง';
    }
    await IfDialog.show(context: context, text: message);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Site.name,
      debugShowCheckedModeBanner:false,
      color: Colors.white,
      builder: (context, child) {
        return FutureBuilder<Widget>(
          future: loadSplash(),
          builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
            if (snapshot.hasData) {
              loadData();
              return snapshot.data;
            } else {
              return IfDialog.getLoading();
            }
          }
        );
      }
    );
  }
}
