import 'package:app1/Home/Controller.dart';
import 'package:app1/Home/Edit/Page.dart';
import 'package:app1/import.dart';
import 'package:app1/libs/SettingLib.dart';
import 'package:app1/libs/SvgViewer.dart';
import 'package:flutter/material.dart';
import '../global.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List tab = ['Công việc', 'Học tập', 'Riêng tư'];
    List a = [{'abc':"abc"},{'abc':"abc"}];
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Note App',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
          ),
          floatingActionButton: InkWell(

            // backgroundColor: Colors.white,
            onTap: () async{
              await Get.delete<HomeController>();
              Get.to(const HomeEditPage());
            },
            child:  const SvgViewer('assets/ic_add_note.svg',width: 50,),
          ),
          body: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  unselectedLabelColor: Colors.grey,
                  labelColor:Colors.blue,
                  tabs: tab.map<Widget>((e) {
                  return Tab(
                    text: e,
                  );
                }).toList()),
                 Expanded(
                   child:  TabBarView(children: [
                     Work(items:controller.listWork,controller: controller),
                     Work(items:controller.listNote,controller: controller),
                     Work(items:controller.listPrivate,controller: controller,),
                ]),
                 )
              ],
            ),
          ),
        );
      }
    );
  }
}
class Work extends StatelessWidget {
  final List items;
  final HomeController controller;
  const Work({Key? key, required this.items, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return items.isNotEmpty? ListView(
    children: makeTreeItems(items, 2).map<Widget>((e){
        return Row(
          crossAxisAlignment : CrossAxisAlignment.start,
          mainAxisSize:MainAxisSize.max,
          children: e.map<Widget>((item){
            return Container(
              width: (Get.width-25)/2,
              margin: const EdgeInsets.all(5),
              color: Colors.amberAccent,
              child: Column(
                mainAxisSize:MainAxisSize.min,
                crossAxisAlignment : CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SvgViewer('assets/dollar-2-6.svg',width: 20),
                      const SizedBox(width: 5),
                      Text( item['date'].toString()??''),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12).copyWith(top: 0),
                    child: Column(
                      crossAxisAlignment : CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        SizedBox(
                            height: 50,
                            child: Text(item['content']??'',maxLines: 3,overflow: TextOverflow.ellipsis,)),
                        const SizedBox(height: 5),
                        Text('Hẹn giờ: ${item['time'] != ''? item['time']:'Không'}'),
                        const SizedBox(height: 5),

                        Row(
                          mainAxisAlignment : MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(onTap: ()async{
                              await Get.delete<HomeController>();
                              int index= (controller.item).indexWhere((element) => element['content'] == item['content']);
                              controller.item.removeAt(index);
                              Setting().put('listNote',controller.item);
                              controller.getList();
                            },child: const SvgViewer('assets/delete-button-svgrepo-com.svg',width: 20)),
                            InkWell(onTap: ()async{
                              await Get.delete<HomeController>();
                              int index= items.indexWhere((element) => element['content'] == item['content']);
                              Get.to(HomeEditPage(item: item,index:index));
                            },child: const SvgViewer('assets/ic_edit_note.svg',width: 20)),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        );
      }).toList(),
    ):const Center(child: Text('Chưa có ghi chú'),);
  }
}
