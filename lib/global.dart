import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:io';
import 'package:app1/libs/SettingLib.dart';
import 'dart:math';
import 'package:intl/intl.dart';

init()async{
  Setting.storageLib = SettingLib();
  Directory? appDocumentDirectory;
  String path;
  appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  path = appDocumentDirectory.path;
  Hive.init(path);
  Setting.storageLib = SettingLib();
  await Setting.init('Config');
}
List makeTreeItems(List? items, int? length){
  if(length == null || length <= 1 || items == null){
    return items??[];
  }
  int _l = length;
  if(items.length < length){
    _l = items.length;
  }
  List _items = [];
  for(int index = 0; index < (items.length/length).ceil(); index++){
    int max = (index * _l) + _l;
    if(max > items.length){
      max = items.length;
    }
    _items.add(items.sublist(index * _l, max));
  }
  return _items;
}
String date([dynamic time, String? format]) {
  String _format = format ?? 'dd/MM/yyyy';
  if (time != null) {
    if ((time is String || time is num)) {
      if(time is int){
        return DateFormat(_format).format(DateTime.fromMillisecondsSinceEpoch(time * 1000));
      }
      final _reg = new RegExp(r'(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})');
      if(time is String && _reg.hasMatch(time)){
        DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
        DateTime dateTime = dateFormat.parse(time.toString().replaceFirst('T', ' '));

        return DateFormat(_format).format(dateTime);
      }
      return DateFormat(_format).format(time);
    }else if(time is DateTime){
      return DateFormat(_format).format(time);
    }
  }else{
    return '';
  }
  return '';
}
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();
String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
