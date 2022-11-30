import 'package:app1/Home/Edit/Controller.dart';
import 'package:app1/Home/Edit/widget/Mission.dart';
import 'package:app1/import.dart';
import 'package:app1/libs/FormTextField.dart';
import 'package:app1/libs/SvgViewer.dart';
import  'package:intl/intl.dart';

class HomeEditPage extends StatelessWidget {
  final Map? item;
  final  int? index;
  const HomeEditPage({Key? key, this.item, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List category = [
      {'categoriesId': 1, 'title': 'Công việc'},
      {'categoriesId': 2, 'title': 'Học tập'},
      {'categoriesId': 3, 'title': 'Riêng tư'},
    ];
    List noTi = [
      {'noTiId': 1, 'title': 'Nhắc trước 5 phút'},
      {'noTiId': 2, 'title': 'Không hẹn giờ'},
    ];
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
      child: GetBuilder<HomeEditController>(
          init: HomeEditController(param: item,index: index),
          builder: (controller) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  item !=null && item!['title']!=''?item!['title']:'Thêm mới',
                  style:
                      const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
                actions: [
                  InkWell( onTap: (){

                  },child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SvgViewer('assets/delete-button-svgrepo-com.svg',width: 24),
                  )),
                  InkWell(
                    onTap: (){
                      controller.submit();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SvgViewer('assets/ic_save_note.svg',width: 26),
                    )),
                ],
                backgroundColor: Colors.white,
                centerTitle: true,
              ),
              body: Obx(() => ListView(
                    padding: const EdgeInsets.only(top: 10),
                    children: [
                      formGroup(child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => InkWell(
                            onTap: () {
                              Get.bottomSheet(
                                Container(
                                  color: Colors.white,
                                  height: Get.height / 3,
                                  padding: const EdgeInsets.all(10),
                                  child: Column(children: [
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Expanded(
                                            child: Center(
                                                child: Text('Danh Mục', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)))),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child:
                                              const Icon(Icons.close)),
                                        )
                                      ],
                                    ),
                                    const Divider(),
                                    ...category.map<Widget>((e) {
                                      return InkWell(
                                        onTap: () {
                                          controller.categoriesId.value = e['categoriesId'];
                                          Get.back();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                controller.categoriesId.value == e['categoriesId'] ? Icons.check_circle : Icons.radio_button_unchecked,
                                                color: Colors.blue,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(e['title']),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList()
                                  ]),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SvgViewer(
                                    'assets/dollar-2-6.svg',width: 35,color: Colors.amber,),
                                const SizedBox(width: 5),
                                Text(controller.categoriesId.value != 0
                                    ? getCategory(
                                    controller.categoriesId.value)
                                    : 'Danh mục'),
                                const SizedBox(width: 5),
                                const Icon(
                                    Icons.keyboard_arrow_down_outlined)
                              ],
                            )),
                          ),
                          Obx(
                            () => InkWell(
                            onTap: () {
                              BottomPicker.date(
                                title: 'Chọn ngày',
                                dismissable: true,
                                initialDateTime: controller.date.value !=''?DateFormat("dd/MM/yyyy").parse(controller.date.value):DateTime.now(),
                                minDateTime: DateTime(1900, 1, 1),
                                maxDateTime: DateTime(2200, 12, 31),
                                onChange: (val) {
                                  // controller.date.value=val.toString();
                                },

                                onClose: () {
                                  controller.date.value = '';
                                },
                                onSubmit: (index) {
                                  controller.date.value =
                                      DateFormat('dd/MM/yyyy')
                                          .format(index)
                                          .toString();
                                },
                              ).show(context);
                            },
                            child: Container(
                              width: 140,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(controller.date.value != ''
                                      ? controller.date.value
                                  // date(controller.date.value,'dd/MM/yyyy')
                                      : DateFormat('dd/MM/yyyy').format(DateTime.now()).toString()),
                                  const SizedBox(width: 5),
                                  const Icon(
                                      Icons.keyboard_arrow_down_outlined)
                                ],
                              ),
                            )),
                          ),
                        ],
                      ) ),
                      const SizedBox(height: 10),
                      formGroup(child:Column(
                  children: [
                    FormTextField(
                      value: controller.title.value != ''
                          ? controller.title.value
                          : '',
                      onChanged: (val) {
                        controller.title.value = val;
                      },
                      maxLength: 64,
                      hintText:  'Tiêu đề',
                    ),
                    const SizedBox(height: 10),
                    Container(
                      color: Colors.amberAccent.withOpacity(0.4),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 12),
                      child: FormTextField(
                        maxLines: 10,
                        minLines: 8,
                        value: controller.content.value != ''
                            ? controller.content.value
                            : '',
                        onChanged: (val) {
                          controller.content.value = val;
                        },
                        maxLength: 1024,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nội dung ghi chú'),
                      ),
                    )
                  ],
                ) ),
                      const SizedBox(height: 10),
                      formGroup(title: 'Địa điểm', child: FormTextField(
                        value: controller.address.value != ''
                            ? controller.address.value
                            : '',
                        onChanged: (val) {
                          controller.address.value = val;
                        },
                        maxLength: 128,
                        hintText:  'Địa điểm'
                      )),
                      const SizedBox(height: 10),
                      formGroup(title: 'Nhắc nhở', child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                Get.bottomSheet(
                                  Container(
                                    color: Colors.white,
                                    height: Get.height / 3,
                                    padding: const EdgeInsets.all(10),
                                    child: Column(children: [
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Expanded(
                                              child: Center(child: Text('Nhắc nhở',
                                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)))),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child:
                                                const Icon(Icons.close)),
                                          )
                                        ],
                                      ),
                                      const Divider(),
                                      ...noTi.map<Widget>((e) {
                                        return InkWell(
                                          onTap: () {
                                            controller.noTi.value = e['noTiId'];
                                            Get.back();
                                          },
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  controller.noTi
                                                      .value ==
                                                      e['noTiId']
                                                      ? Icons.check_circle
                                                      : Icons
                                                      .radio_button_unchecked,
                                                  color: Colors.blue,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(e['title']),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList()
                                    ]),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 5),
                                    Text(controller.noTi.value != 0
                                        ? (controller.noTi.value == 1?'Nhắc trước 5 phút':'Không hẹn giờ')
                                        : 'Chọn'),
                                    const SizedBox(width: 5),
                                    const Icon(
                                        Icons.keyboard_arrow_down_outlined)
                                  ],
                                ),
                              )),
                          if(controller.noTi.value == 1)InkWell(
                              onTap: () {
                                BottomPicker.time(
                                  title: 'Chọn giờ',
                                  dismissable: true,
                                  initialDateTime:controller.time.value !=''?DateFormat('HH:mm').parse(controller.time.value) :DateTime.now(),
                                  minDateTime: DateTime(1900, 1, 1),
                                  maxDateTime: DateTime(2200, 12, 31),
                                  onChange: (val) {
                                  },
                                  onClose: () {
                                    controller.time.value = '';
                                  },
                                  onSubmit: (index) {
                                    controller.time.value =
                                        DateFormat('HH:mm')
                                            .format(index)
                                            .toString();
                                  },
                                ).show(context);
                              },
                              child: Container(
                                width: 140,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(controller.time.value != ''
                                        ? controller.time.value
                                        : 'Chọn giờ'),
                                    const SizedBox(width: 5),
                                    const Icon(Icons.keyboard_arrow_down_outlined)
                                  ],
                                ),
                              )),
                        ],
                      )),
                      const SizedBox(height: 10),
                      formGroup(title: 'Nhiệm vụ', child: HomeEditMission(
                        controller: controller,
                      )),
                      const SizedBox(height: 30),
                    ],
                  )),
            );
          }),
    );
  }

  getCategory(int id) {
    switch (id) {
      case 1:
        return 'Công việc';
      case 2:
        return 'Học tập';
      case 3:
        return 'Riêng tư';
      default:
        '';
    }
  }
}
Widget formGroup({String? title,required Widget child} ){
  return    Container(
    color: Colors.deepOrangeAccent.withOpacity(0.05),
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         if(title != null)...[Text(title,
             style: const TextStyle(
                 fontSize: 16, fontWeight: FontWeight.w600)),
           const SizedBox(height: 10)],
        child,
      ],
    ),
  );
}

