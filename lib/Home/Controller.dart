
import 'package:app1/import.dart';
import 'package:app1/libs/SettingLib.dart';

class HomeController extends GetxController {
  bool mounted = true;

  RxList listNote= [].obs;
  RxList listWork= [].obs;
  RxList listPrivate= [].obs;
  List item=[];
  @override
  void onInit() {
  getList();
  super.onInit();
  }
  getList() async{
    if (Setting().get('listNote') !=null){
      item = await Setting().get('listNote');
      for (var element in item) {
        if(element['categoriesId']==1){
          listWork.value = listWork.value..add(element);
        }
        if(element['categoriesId']==2){
          listNote.value = listNote.value..add(element);
        }
        if(element['categoriesId']==3){
          listPrivate.value = listPrivate.value..add(element);
        }
      }
    }else{
    }
    if(mounted){
      update();
    }
  }
  @override
  onClose() {
    mounted = false;
    super.onClose();
  }
}