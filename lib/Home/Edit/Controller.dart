import 'dart:core';
import 'package:app1/import.dart';
import 'package:app1/libs/SettingLib.dart';
import  'package:intl/intl.dart';

class HomeEditController extends GetxController {
  final Map? param;

  HomeEditController({this.param});
  RxString date= ''.obs;
  RxString time= ''.obs;
  RxString title= ''.obs;
  RxString content= ''.obs;
  RxString address= ''.obs;
  RxString textMiss= ''.obs;
  RxList listMiss= [].obs;
  RxInt categoriesId= 1.obs;
  RxInt noTi= 0.obs;

  @override
  void onInit() {
    if(param !=null){
      title.value=param!['title']??'';
      date.value=param!['date'].toString();
      time.value=param!['time']??'';
      content.value=param!['content']??'';
      address.value=param!['address']??'';
      categoriesId.value=param!['categoriesId']??'';
      noTi.value=param!['noTi']??'';
      listMiss.value=param!['listMiss']??'';
    }
    super.onInit();
  }
  @override
  void dispose() {
    date.close();
    categoriesId.close();
    title.close();
    content.close();
    address.close();
    noTi.close();
    listMiss.close();
    textMiss.close();
    categoriesId.close();
    super.dispose();
  }
  submit() async{
    List listNote= await Setting().get('listNote');

    if(content.value == ''){
      Get.snackbar('Thông báo', 'Bạn chưa nhập nội dung ghi chú.Vui lòng nhập nội dung ghi chú để tiếp tục!',
          backgroundColor: Colors.red,colorText: Colors.white,duration: const Duration(seconds: 5));
    }else{
        Map item={
          'title':title.value !=''?title.value:content.value.substring(0,content.value.length>25?25:content.value.length),
          'date':date.value != ''?date.value: DateFormat('dd/MM/yyyy').format(DateTime.now()).toString(),
          'time':time.value??'',
          'content':content.value??'',
          'address':address.value??'',
          'categoriesId':categoriesId.value,
          'noTi':noTi.value,
          'listMiss':listMiss??[],
        };
        if(param !=null){
          listNote[param!['index']]=item;
          Setting().put('listNote',listNote);
          Get.offAllNamed('/');
        }else{
          Setting().put('listNote',listNote..add(item));
          Get.offAllNamed('/');
        }
    }
  }

}