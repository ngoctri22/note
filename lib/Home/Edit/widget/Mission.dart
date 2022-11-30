import 'package:app1/Home/Edit/Controller.dart';
import 'package:app1/libs/FormTextField.dart';
import 'package:app1/libs/SvgViewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeEditMission extends StatelessWidget {
  final HomeEditController? controller;
  const HomeEditMission({Key? key,this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Column(
      children: [
        if(controller!.listMiss.isNotEmpty)...controller!.listMiss.map<Widget>((e) {
          return InkWell(
            onTap: () {
              e['active']=(e['active']==1?0:1);
              controller!.update();
            },
            child: Padding(
              padding:
              const EdgeInsets.symmetric(
                  vertical: 8.0),
              child: Row(
                children: [
                  Icon(e['active']==1?Icons.check_box: Icons .check_box_outline_blank),
                  const SizedBox(width: 8),
                  Expanded(child: Text(e['title'],style: TextStyle(decoration:e['active']==1? TextDecoration.lineThrough:null),)),
                ],
              ),
            ),
          );
        }).toList(),
        SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: FormTextField(
                value: controller!.textMiss.value != ''
                    ? controller!.textMiss.value
                    : '',
                onChanged: (val) {
                  controller!.textMiss.value = val;
                },
              ),
            ),
            const SizedBox(width: 5),
            InkWell(
                onTap:controller!.textMiss.value!= ''? (){
                  print(controller!.listMiss);
                  print(controller!.listMiss.value);
                  if(controller!.textMiss.value!= ''){
                    final bool res = check(controller!.listMiss, controller!.textMiss.value!) ?? true;
                    if(!res){
                      Get.snackbar('Thông báo', 'Nhiệm vụ mới thêm đã tồn tại. Vui lòng nhập khác!',backgroundColor: Colors.red,colorText: Colors.white);
                    }else{
                      controller!.listMiss.add({'title':controller!.textMiss.value,'active':0});
                      controller!.textMiss.value='';
                    }
                  }else{
                    Get.snackbar('Thông báo', 'Bạn chưa nhập nhiệm vụ',backgroundColor: Colors.red,colorText: Colors.white);
                  }
                }:null,
                child: SvgViewer(controller!.textMiss.value!= ''?'assets/ic_add_sub_task.svg':'assets/ic_add_sub_task2.svg',width: 50,)
            )
          ],
        ),
      ],
    ));
  }
  check(List item,String name){
    for (var element in item) {
      if(element['title'] != name) {
        continue;
      }else {
        return false;
      }
    }
  }
}
