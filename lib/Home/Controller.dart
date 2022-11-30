
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
    super.onInit();
    getList();

  }

  getList() async{
    listWork.value=[];
    listPrivate.value=[];
    listNote.value=[];
    item = await Setting().get('listNote') ??[];
    print('---33-$item');
    if (Setting().get('listNote') !=null){
      for (var element in item) {
        if(element['categoriesId']==1){
          print('----------------1---${listWork.contains(element)}');
          if(!listWork.contains(element)){
              listWork.value = listWork.value..add(element);
          }
        }
        if(element['categoriesId']==2){
          if(!listNote.contains(element)){
            listNote.value = listNote.value..add(element);
          }
        }
        if(element['categoriesId']==3){
          print('----1');
          if(!listPrivate.contains(element)){
            listPrivate.value = listPrivate.value..add(element);
          }
          print('----1${ listPrivate.value}');
        }
      }
    }
    if(mounted){
       update();
    }
  }
  @override
  void dispose() {
    listNote.close();
    listWork.close();
    listPrivate.close();
    mounted = false;
    super.dispose();
  }
}