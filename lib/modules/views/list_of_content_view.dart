import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:my_ossc/modules/controllers/list_of_content_controller.dart';
import 'package:my_ossc/modules/widgets/edit_menu.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../../api/services/time_format.dart';
import '../../constants/colors.dart';
import '../../constants/notosansthai.dart';
import '../../models/new_ossc_data_model.dart';
import '../../models/ossc_data_model.dart';
// import '../widgets/add_information.dart';
import '../controllers/loc_controller.dart';
import '../widgets/add_information_copy.dart';
import '../widgets/export_information.dart';
import '../widgets/file_view.dart';

class ListOfContent extends GetView<LocController> {
  const ListOfContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.storke,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          header(context),
          const Spacer(),
          Obx(
            () => controller.isLoading.value
                ? const Center(
                    // alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 166,
                    child: AdaptiveScrollbar(
                      controller: controller.vertical,
                      child: AdaptiveScrollbar(
                        controller: controller.horizontal,
                        position: ScrollbarPosition.bottom,
                        width: 16,
                        underSpacing: const EdgeInsets.only(bottom: 16),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 166,
                          child: SingleChildScrollView(
                              primary: false,
                              controller: controller.horizontal,
                              scrollDirection: Axis.horizontal,
                              child: SingleChildScrollView(
                                controller: controller.vertical,
                                primary: false,
                                child: StickyHeader(
                                    header: cell(data: controller.listHeader),
                                    content: Column(
                                      children: [
                                        // for (var doc in controller.osscData)
                                        for (var i = 0;
                                            i < controller.newOssc.length;
                                            i++)
                                          InkWell(
                                              onTap: () {
                                                Menu().list(
                                                    i,
                                                    controller.newOssc[i]
                                                            .company ??
                                                        '',
                                                    controller.newOssc[i].act!,
                                                    controller.newOssc[i].desc!,
                                                    context,
                                                    receiveNumber: controller
                                                            .newOssc[i]
                                                            .receiveNumber ??
                                                        '');
                                                print(i);
                                              },
                                              child: cell2(
                                                  data: controller.newOssc[i],
                                                  index: i + 1))
                                      ],
                                    )),
                              )),
                        ),
                      ),
                    ),
                  ),
          ),
          const Spacer()
        ],
      ),
    );
  }

  Widget header(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
        height: 158,
        decoration: const BoxDecoration(color: Palette.lightGrey),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  alignment: Alignment.topCenter,
                  width: 86,
                  height: 36,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Palette.mainGreen),
                  child: InkWell(
                    onTap: () async {
                      // await controller.loadInformation();
                      // ignore: use_build_context_synchronously
                      AddListOfContentPopup().add(context);
                    },
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'เพิ่ม',
                            style:
                                NotoSansThai.h3.copyWith(color: Palette.black),
                          ),
                          const Icon(
                            Icons.add,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Text(
                  'ศูนย์ราชการสะดวก',
                  style: NotoSansThai.h1.copyWith(color: Palette.black),
                  overflow: TextOverflow.clip,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 0, bottom: 16),
                      child: Container(
                        child: Text(
                          'ชื่อผู้ใช้งาน: ${controller.name.value}',
                          style: NotoSansThai.h2,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      alignment: Alignment.topCenter,
                      width: 86,
                      height: 36,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Palette.mainGreen),
                      child: InkWell(
                        onTap: () {
                          controller.getInformation();
                        },
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'รีเฟชร',
                                style: NotoSansThai.h3
                                    .copyWith(color: Palette.black),
                              ),
                              const Icon(
                                Icons.refresh,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            //ANCHOR - Search
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'พ.ร.บ',
                      style: NotoSansThai.h4.copyWith(color: Palette.black),
                    ),
                    SizedBox(
                      height: 38,
                      width: 280,
                      child: FormBuilderDropdown(
                          borderRadius: BorderRadius.circular(16),
                          onChanged: (value) async {
                            await controller.setAct(
                                dropdownDetail: value!, added: false);
                            controller.searchInformation();
                          },
                          name: 'act',
                          decoration: customInputDecoration(hintText: 'พ.ร.บ'),
                          isExpanded: true,
                          items: controller.listFilterAct
                              .map(
                                (option) => DropdownMenuItem(
                                  value: option,
                                  child: Text(
                                    option,
                                    style: NotoSansThai.normal
                                        .copyWith(color: Palette.black),
                                  ),
                                ),
                              )
                              .toList()),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ธุรกรรม',
                      style: NotoSansThai.h4.copyWith(color: Palette.black),
                    ),
                    SizedBox(
                      height: 38,
                      width: 240,
                      child: FormBuilderDropdown(
                          borderRadius: BorderRadius.circular(16),
                          onChanged: (value) async {
                            await controller.setDesc(
                                dropdownDetail: value!, added: false);
                            controller.searchInformation();
                          },
                          name: 'desc',
                          decoration:
                              customInputDecoration(hintText: 'ธุรกรรม'),
                          isExpanded: true,
                          items: controller.listFilterDesc
                              .map(
                                (option) => DropdownMenuItem(
                                  value: option,
                                  child: Text(
                                    option,
                                    style: NotoSansThai.normal
                                        .copyWith(color: Palette.black),
                                  ),
                                ),
                              )
                              .toList()),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ค้นหา',
                      style: NotoSansThai.h4.copyWith(color: Palette.black),
                    ),
                    SizedBox(
                        height: 38,
                        width: 420,
                        child: TextField(
                          textInputAction: TextInputAction.go,
                          controller: controller.searchController,
                          onSubmitted: (value) {
                            print(controller.searchController.value.text);
                            controller.searchInformation();
                          },
                          // onChanged: (value) {
                          //   print(value);
                          //   controller.searchInformation();
                          // },
                        )),
                  ],
                ),
                const SizedBox(width: 16),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    alignment: Alignment.topCenter,
                    width: 60,
                    height: 32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Palette.mainGreen),
                    child: InkWell(
                      onTap: () {
                        print(controller.searchController.value.text);
                        controller.searchInformation();
                      },
                      child: Text(
                        'ค้นหา',
                        style: NotoSansThai.h3.copyWith(color: Palette.black),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    // controller.exportDate(act: '', desc: '');
                    Export().informationPopup(context);
                  },
                  child: const Card(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('ส่งออกข้อมูล'),
                  )),
                )
              ],
            )
          ],
        ),
      );
  Widget cell({required List<String> data}) => Container(
        height: 48,
        color: Palette.greyIcon,
        child: Row(
          children: [
            //ANCHOR - ลำดับ
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              alignment: Alignment.center,
              width: 60,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[0]),
            ),
            //ANCHOR - วัน/เดือน/ปี
            Container(
              alignment: Alignment.center,
              width: 160,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[1]),
            ),
            //ANCHOR - เลขรับ
            Container(
              alignment: Alignment.center,
              width: 100,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[2]),
            ),
            //ANCHOR - ชื่อผู้รับ
            Container(
              alignment: Alignment.center,
              width: 240,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[3]),
            ),
            //ANCHOR - ชื่อสถานประกอบการ
            Container(
              alignment: Alignment.center,
              width: 240,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[4]),
            ),
            //ANCHOR - อำเภอ
            Container(
              alignment: Alignment.center,
              width: 120,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[5]),
            ),
            //ANCHOR - เบอร์
            Container(
              alignment: Alignment.center,
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[6]),
            ),
            //ANCHOR  พ.ร.บ
            Container(
              alignment: Alignment.center,
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[7]),
            ),
            //ANCHOR - ประเภทสถานที่
            Container(
              alignment: Alignment.center,
              width: 120,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[8]),
            ),
            //ANCHOR  ธุรกรรม
            Container(
              alignment: Alignment.center,
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[9]),
            ),
            //ANCHOR  ค่าธรรมเนียม
            Container(
              alignment: Alignment.center,
              width: 100,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[10]),
            ),
            //ANCHOR  การชำระค่าธรรมเนียม
            Container(
              alignment: Alignment.center,
              width: 150,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[11]),
            ),
            //ANCHOR  เอกสารคำขอ
            Container(
              alignment: Alignment.center,
              width: 100,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[12]),
            ),
            //ANCHOR  เจ้าหน้าที่รับคำขอ
            Container(
              alignment: Alignment.center,
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[13]),
            ),
            //ANCHOR  สถานะเอกสาร
            Container(
              alignment: Alignment.center,
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[14]),
            ),
            //ANCHOR  ทีมตรวจรับเอกสาร
            Container(
              alignment: Alignment.center,
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[15]),
            ),
            //ANCHOR  วันที่รับ
            Container(
              alignment: Alignment.center,
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[16]),
            ),
            //ANCHOR  รอตรวจสถานที่
            Container(
              alignment: Alignment.center,
              width: 220,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[17]),
            ),
            //ANCHOR  ตรวจสถานที่
            Container(
              alignment: Alignment.center,
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[18]),
            ),
            //ANCHOR  ผลตรวจ
            Container(
              alignment: Alignment.center,
              width: 100,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[19]),
            ),
            //ANCHOR  สถานะการตรวจ
            Container(
              alignment: Alignment.center,
              width: 160,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[20]),
            ),
            //ANCHOR  ส่งผลตรวจ
            Container(
              alignment: Alignment.center,
              width: 160,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[21]),
            ),
            //ANCHOR  เจ้าหน้าที่ส่งผลตรวจ
            Container(
              alignment: Alignment.center,
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[22]),
            ),
            //ANCHOR  การรับเอกสาร
            Container(
              alignment: Alignment.center,
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[23]),
            ),
            //ANCHOR  วันที่รับผลตรวจ
            Container(
              alignment: Alignment.center,
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[24]),
            ),
            //ANCHOR  ชื่อผู้รับ
            Container(
              alignment: Alignment.center,
              width: 160,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[25]),
            ),
            //ANCHOR  ลายเซ็นผู้รับ
            Container(
              alignment: Alignment.center,
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[26]),
            ),
            //ANCHOR  ใบอนุญาต
            Container(
              alignment: Alignment.center,
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[27]),
            ),
            //ANCHOR  วันที่
            Container(
              alignment: Alignment.center,
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[28]),
            ),
            //ANCHOR  ค่าธรรมเนียมใบอนุญาต
            Container(
              alignment: Alignment.center,
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[29]),
            ),
            //ANCHOR  หลักฐานการชำระ
            Container(
              alignment: Alignment.center,
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[30]),
            ),
            //ANCHOR  เลขสถานที่
            Container(
              alignment: Alignment.center,
              width: 180,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[31]),
            ),
            //ANCHOR  เลขใบอนุญาต
            Container(
              alignment: Alignment.center,
              width: 180,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[32]),
            ),
            //ANCHOR  เลขใบอนุญาตประกอบกิจ
            Container(
              alignment: Alignment.center,
              width: 180,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[33]),
            ),
            //ANCHOR  เลขใบอนุญาตดำเนินการ
            Container(
              alignment: Alignment.center,
              width: 180,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[34]),
            ),
            //ANCHOR  เลขใบอนุญาตโฆษณา
            Container(
              alignment: Alignment.center,
              width: 180,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[35]),
            ),
            //ANCHOR  เลขใบอนุญาตผู้ดำเนินการสปา
            Container(
              alignment: Alignment.center,
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[36]),
            ),
            //ANCHOR  รับใบอนุญาต
            Container(
              alignment: Alignment.center,
              width: 160,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[37]),
            ),
            //ANCHOR  วันที่รับ
            Container(
              alignment: Alignment.center,
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[38]),
            ),
            //ANCHOR  เลขพัสดุ
            Container(
              alignment: Alignment.center,
              width: 160,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[39]),
            ),
            //ANCHOR  ลายเซ็น
            Container(
              alignment: Alignment.center,
              width: 150,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[40]),
            ),
            //ANCHOR  สถานนะ
            Container(
              alignment: Alignment.center,
              width: 80,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data[41]),
            ),
          ],
        ),
      );
//SECTION - cell
  Widget cell2({required OsscDataNew data, required int index}) => Container(
        color: data.status.toString() == 'เสร็จสิ้น'
            ? Color.fromARGB(255, 152, 242, 198)
            : index % 2 == 0
                ? const Color.fromARGB(255, 232, 231, 234)
                : Palette.white,
        child: Row(
          children: [
            //ANCHOR - ลำดับ
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              alignment: Alignment.center,
              width: 60,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(index.toString()),
            ),
            //ANCHOR - วัน/เดือน/ปี
            Container(
              alignment: Alignment.center,
              width: 160,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(TimeFormat().getDate(date: data.date.toString())),
            ),
            //ANCHOR - เลขรับ
            Container(
              alignment: Alignment.center,
              width: 100,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.receiveNumber ?? ''),
            ),
            //ANCHOR - ชื่อผู้รับ
            Container(
              alignment: Alignment.center,
              width: 240,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(
                data.customer ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            //ANCHOR - ชื่อสถานประกอบการ
            Container(
              alignment: Alignment.center,
              width: 240,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.company ?? ''),
            ),
            //ANCHOR - อำเภอ
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.district ?? ''),
            ),
            //ANCHOR - เบอร์
            Container(
              alignment: Alignment.center,
              width: 140,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.tel ?? ''),
            ),
            //ANCHOR  พ.ร.บ
            Container(
              alignment: Alignment.center,
              width: 200,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.act ?? ''),
            ),
            //ANCHOR - ประเภทสถานที่
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.type ?? ''),
            ),
            //ANCHOR  ธุรกรรม
            Container(
              alignment: Alignment.center,
              width: 140,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.desc ?? ''),
            ),
            //ANCHOR  ค่าธรรมเนียม
            Container(
              alignment: Alignment.center,
              width: 100,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.cost ?? ''),
            ),
            //ANCHOR  การชำระค่าธรรมเนียม
            Container(
              alignment: Alignment.center,
              width: 150,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: data.slipUrl == null || data.slipUrl == '-'
                  ? const Text('')
                  : InkWell(
                      onTap: () async {
                        await controller.getRequireInformation(
                            isFile: false,
                            folder: '/04_Premarketing',
                            act: 'slip',
                            fileName: data.slipUrl.toString(),
                            dir: '',
                            des: '');
                        // controller.getFileUrl(
                        //     folder: 'image', fileName: data.slipUrl.toString());
                        FilePopUp().image(
                            label: 'การชำระค่าธรรมเนียม',
                            filePath: controller.filePath.value,
                            token: controller.token.value);
                        // print(
                        //     'ดูรูป ${await controller.getFileUrl(folder: 'image', fileName: data.slipUrl.toString())}');
                      },
                      child: Stack(children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Palette.mainGreen,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.search_outlined,
                                  size: 16,
                                  color: Palette.white,
                                ),
                                Text(
                                  'การชำระค่าธรรมเนียม',
                                  style: NotoSansThai.smallLabel
                                      .copyWith(color: Palette.white),
                                ),
                              ],
                            ))
                      ]),
                    ),
            ),
            //ANCHOR  เอกสารคำขอ
            Container(
              alignment: Alignment.center,
              width: 100,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Container(
                decoration: BoxDecoration(
                    color: Palette.mainGreen,
                    borderRadius: BorderRadius.circular(8)),
                child: data.doc == null || data.doc == '-'
                    ? const Text('')
                    : InkWell(
                        onTap: () async {
                          FilePopUp().document(
                              fileName: '${data.doc}',
                              act: data.act!,
                              dir: '/เอกสารคำขอ',
                              des:
                                  '/${data.receiveNumber?.split('/')[1]}/${data.desc?.replaceAll('/', ' ')}/${data.receiveNumber?.replaceAll('/', '-')}');
                          print('ดูเอกสารแนบ ${data.doc?.split(', ')[0]}');
                        },
                        child: Stack(children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Palette.mainGreen,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.search_outlined,
                                    size: 16,
                                    color: Palette.white,
                                  ),
                                  Text(
                                    'เอกสารแนบ',
                                    style: NotoSansThai.smallLabel
                                        .copyWith(color: Palette.white),
                                  ),
                                ],
                              ))
                        ]),
                      ),
              ),
            ),
            //ANCHOR  เจ้าหน้าที่รับคำขอ
            Container(
              alignment: Alignment.center,
              width: 200,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.requestStaff ?? ''),
            ),
            //ANCHOR  สถานะเอกสาร
            Container(
              alignment: Alignment.center,
              width: 200,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.docStatus ?? ''),
            ),
            //ANCHOR  ทีมตรวจรับเอกสาร
            Container(
              alignment: Alignment.center,
              width: 200,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.inspectionTeam ?? ''),
            ),
            //ANCHOR  วันที่รับ
            Container(
              alignment: Alignment.center,
              width: 140,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(TimeFormat().getDate(date: data.recivedDate ?? '')),
            ),
            //ANCHOR  รอตรวจสถานที่
            Container(
              alignment: Alignment.center,
              width: 220,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.waitingToCheck ?? ''),
            ),

            //ANCHOR  ตรวจสถานที่
            Container(
              alignment: Alignment.center,
              width: 200,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(
                  TimeFormat().getDateTime(date: data.checkLocation ?? "")),
            ),
            //ANCHOR  ผลตรวจ
            Container(
              alignment: Alignment.center,
              width: 100,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Container(
                decoration: BoxDecoration(
                    color: Palette.mainGreen,
                    borderRadius: BorderRadius.circular(8)),
                child: data.results == null || data.results == ''
                    ? Text(data.results ?? "")
                    : InkWell(
                        onTap: () {
                          FilePopUp().document(
                              fileName: '${data.results}',
                              act: data.act!,
                              dir: '/เอกสารผลตรวจ',
                              des:
                                  '/${data.receiveNumber?.split('/')[1]}/${data.receiveNumber?.replaceAll('/', '-')}');
                          print('ดูเอกสารแยบ ${data.results}');
                        },
                        child: Stack(children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Palette.mainGreen,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.search_outlined,
                                    size: 16,
                                    color: Palette.white,
                                  ),
                                  Text(
                                    'เอกสารแนบ',
                                    style: NotoSansThai.smallLabel
                                        .copyWith(color: Palette.white),
                                  ),
                                ],
                              ))
                        ]),
                      ),
              ),
            ),
            //ANCHOR  สถานะการตรวจ,
            Container(
              alignment: Alignment.center,
              width: 160,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.resultsStatus ?? ''),
            ),
            //ANCHOR  ส่งผลตรวจ
            Container(
              alignment: Alignment.center,
              width: 160,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(TimeFormat().getDate(date: data.sendResults ?? "")),
            ),
            //ANCHOR  เจ้าหน้าที่ส่งผลตรวจ
            Container(
              alignment: Alignment.center,
              width: 200,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.officer2 ?? ''),
            ),
            //ANCHOR  การรับเอกสาร
            Container(
              alignment: Alignment.center,
              width: 140,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.recived ?? ''),
            ),
            //ANCHOR  วันที่รับผลตรวจ
            Container(
              alignment: Alignment.center,
              width: 140,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(
                  TimeFormat().getDate(date: data.recivedResultDate ?? "")),
            ),
            //ANCHOR  ชื่อผู้รับ
            Container(
              alignment: Alignment.center,
              width: 160,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.recivedName ?? ''),
            ),
            //ANCHOR  ลายเซ็นผู้รับ
            Container(
              alignment: Alignment.center,
              width: 140,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: data.recivedSign == null || data.recivedSign == ''
                  ? Text(data.recivedSign ?? "")
                  : InkWell(
                      onTap: () async {
                        await controller.getRequireInformation(
                            isFile: false,
                            folder: '/04_Premarketing',
                            act: data.act!,
                            fileName: data.recivedSign ?? "",
                            dir: '/signature',
                            des:
                                '/${data.receiveNumber?.replaceAll('/', '-')}');
                        // controller.getFileUrl(
                        //     folder: 'image', fileName: data.slipUrl??"");
                        FilePopUp().image(
                            label: 'ลายเซ็น',
                            filePath: controller.filePath.value,
                            token: controller.token.value);
                        // print(
                        //     'ดูรูป ${await controller.getFileUrl(folder: 'image', fileName: data.slipUrl??"")}');
                      },
                      child: Stack(children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Palette.mainGreen,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.search_outlined,
                                  size: 16,
                                  color: Palette.white,
                                ),
                                Text(
                                  'ลายเซ็น',
                                  style: NotoSansThai.smallLabel
                                      .copyWith(color: Palette.white),
                                ),
                              ],
                            ))
                      ]),
                    ),
            ),
            //ANCHOR  ใบอนุญาต
            Container(
              alignment: Alignment.center,
              width: 200,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Container(
                decoration: BoxDecoration(
                    color: Palette.mainGreen,
                    borderRadius: BorderRadius.circular(8)),
                child: data.license == null || data.license == ''
                    ? Text(data.license ?? "")
                    : InkWell(
                        onTap: () {
                          FilePopUp().document(
                              fileName: '${data.license}',
                              act: data.act!,
                              dir: '/ใบอนุญาต',
                              des:
                                  '/${data.receiveNumber?.split('/')[1]}/${data.receiveNumber?.replaceAll('/', '-')}');
                          print('ดูเอกสารแยบ ${data.license}');
                        },
                        child: Stack(children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Palette.mainGreen,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.search_outlined,
                                    size: 16,
                                    color: Palette.white,
                                  ),
                                  Text(
                                    'เอกสารแนบ',
                                    style: NotoSansThai.smallLabel
                                        .copyWith(color: Palette.white),
                                  ),
                                ],
                              ))
                        ]),
                      ),
              ),
            ),
            // //ANCHOR  วันที่
            Container(
              alignment: Alignment.center,
              width: 140,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(TimeFormat().getDate(date: data.licenseDate ?? "")),
            ),
            // //ANCHOR  ค่าธรรมเนียมใบอนุญาต
            Container(
              alignment: Alignment.center,
              width: 140,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.licenseFee ?? ""),
            ),
            //ANCHOR  หลักฐานการชำระ
            Container(
              alignment: Alignment.center,
              width: 140,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: data.licenseFeeSlip == null ||
                      data.licenseFeeSlip == '-' ||
                      data.licenseFeeSlip == ''
                  ? Text(data.licenseFeeSlip ?? "")
                  : InkWell(
                      onTap: () async {
                        await controller.getRequireInformation(
                            isFile: false,
                            folder: '/04_Premarketing',
                            act: 'slip',
                            fileName: data.licenseFeeSlip ?? "",
                            dir: '',
                            des: '');
                        // controller.getFileUrl(
                        //     folder: 'image', fileName: data.slipUrl??"");
                        FilePopUp().image(
                            label: 'หลักฐานการชำระ',
                            filePath: controller.filePath.value,
                            token: controller.token.value);
                        // print(
                        //     'ดูรูป ${await controller.getFileUrl(folder: 'image', fileName: data.slipUrl??"")}');
                      },
                      child: Stack(children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Palette.mainGreen,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.search_outlined,
                                  size: 16,
                                  color: Palette.white,
                                ),
                                Text(
                                  'การชำระค่าธรรมเนียม',
                                  style: NotoSansThai.smallLabel
                                      .copyWith(color: Palette.white),
                                ),
                              ],
                            ))
                      ]),
                    ),
            ),
            //ANCHOR  เลขสถานที่
            Container(
              alignment: Alignment.center,
              width: 180,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.placeNumber ?? ""),
            ),
            //ANCHOR  เลขใบอนุญาต
            Container(
              alignment: Alignment.center,
              width: 180,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.licenseNumber ?? ""),
            ),
            //ANCHOR  เลขใบอนุญาตประกอบกิจ
            Container(
              alignment: Alignment.center,
              width: 180,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.businessLicenseNumber ?? ""),
            ),
            //ANCHOR  เลขใบอนุญาตดำเนินการ
            Container(
              alignment: Alignment.center,
              width: 180,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.operationLicenseNumber ?? ""),
            ),
            //ANCHOR  เลขใบอนุญาตโฆษณา
            Container(
              alignment: Alignment.center,
              width: 180,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.advertisingLicenseNumber ?? ""),
            ),
            //ANCHOR  เลขใบอนุญาตผู้ดำเนินการสปา
            Container(
              alignment: Alignment.center,
              width: 200,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.spaOperatorLicenseNumber ?? ""),
            ),
            //ANCHOR  รับใบอนุญาต
            Container(
              alignment: Alignment.center,
              width: 160,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.sign ?? ""),
            ),
            //ANCHOR  วันที่รับ
            Container(
              alignment: Alignment.center,
              width: 140,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(TimeFormat().getDate(date: data.receiveDate ?? "")),
            ),
            //ANCHOR  เลขพัสดุ
            Container(
              alignment: Alignment.center,
              width: 160,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.parcelNumber ?? ""),
            ),
            //ANCHOR  ลายเซ็น
            Container(
              alignment: Alignment.center,
              width: 150,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: data.signature == null || data.signature == ''
                  ? Text(data.signature ?? "")
                  : InkWell(
                      onTap: () async {
                        await controller.getRequireInformation(
                            isFile: false,
                            folder: '/04_Premarketing',
                            act: data.act!,
                            fileName: data.signature ?? "",
                            dir: '/signature',
                            des:
                                '/${data.receiveNumber?.replaceAll('/', '-')}');
                        // controller.getFileUrl(
                        //     folder: 'image', fileName: data.slipUrl??"");
                        FilePopUp().image(
                            label: 'ลายเซ็น',
                            filePath: controller.filePath.value,
                            token: controller.token.value);
                        // print(
                        //     'ดูรูป ${await controller.getFileUrl(folder: 'image', fileName: data.slipUrl??"")}');
                      },
                      child: Stack(children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Palette.mainGreen,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.search_outlined,
                                  size: 16,
                                  color: Palette.white,
                                ),
                                Text(
                                  'ลายเซ็น',
                                  style: NotoSansThai.smallLabel
                                      .copyWith(color: Palette.white),
                                ),
                              ],
                            ))
                      ]),
                    ),
            ),
            //ANCHOR  สถานนะ
            Container(
              alignment: Alignment.center,
              width: 80,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Palette.black)),
              child: Text(data.status ?? ""),
            ),
          ],
        ),
      );
}
