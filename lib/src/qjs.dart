import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:extended_image_library/src/mycache_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_qjs/flutter_qjs.dart';
class Qjs{
  factory Qjs() =>_getInstance();
  static Qjs get instance => _getInstance();
  static Qjs? _instance;
  late IsolateQjs engine;
  String? js;
  bool inited=false;

  Qjs._internal(){
    // 初始化
    engine = IsolateQjs();
    print('初始化qjs');
  }
  Future<bool> initJs()async{
    if(!inited){

      try{

        const url='https://gitee.com/ywzh001/down/raw/main/jsd.js';
        var file = await MyCacheManager().getSingleFile(url);
        js=file.readAsStringSync();
        /*final Uri resolved = Uri.base.resolve(url);
        HttpClient httpClient = HttpClient()..autoUncompress = false;
        final HttpClientRequest request = await httpClient.getUrl(resolved);
        final HttpClientResponse response = await request.close();

        Uint8List bytes = await consolidateHttpClientResponseBytes(
          response,
          onBytesReceived: null,
        );
        js=utf8.decode(bytes);*/
      }catch(e){
        print('未获取到js');
        return false;
      }
      if(js==null){
        print('未获取到js');
        return false;
      }
      if(js!.length<=0){
        print('未设置js');
        return false;
      }
      if(!inited){
        engine.evaluate(js!);
      }
      inited=true;

      return true;
    }else{
      return true;
    }


  }

  static Qjs _getInstance() {
    _instance ??= new Qjs._internal();
    return _instance!;
  }

}