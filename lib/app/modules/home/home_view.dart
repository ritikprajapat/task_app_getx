import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_app_getx/app/core/utils/extensions.dart';
import 'package:task_app_getx/app/core/values/colors.dart';
import 'package:task_app_getx/app/data/models/task.dart';
import 'package:task_app_getx/app/modules/home/home_controller.dart';
import 'package:task_app_getx/app/modules/home/widgets/add_dialog.dart';
import '../report/report_view.dart';
import 'widgets/add_cart.dart';
import 'widgets/task_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0.wp),
                    child: Text(
                      'My List',
                      style: TextStyle(
                        fontSize: 24.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Obx(
                    () => GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      children: [
                        ...controller.tasks
                            .map(
                              (element) => LongPressDraggable(
                                data: element,
                                child: TaskCard(
                                  task: element,
                                ),
                                feedback: Opacity(
                                  opacity: 0.8,
                                  child: TaskCard(
                                    task: element,
                                  ),
                                ),
                                onDragStarted: () => controller.changeDeleting(
                                  true,
                                ),
                                onDraggableCanceled: (_, __) => controller.changeDeleting(
                                  false,
                                ),
                                onDragEnd: (_) => controller.changeDeleting(
                                  false,
                                ),
                              ),
                            )
                            .toList(),
                        AddCart(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ReportView(),
          ],
        ),
      ),
      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) {
          return Obx(
            () => Container(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                backgroundColor: controller.deleting.value ? Colors.red : blue,
                onPressed: () {
                  if (controller.tasks.isNotEmpty) {
                    Get.to(AddDialog(), transition: Transition.downToUp);
                  } else {
                    EasyLoading.showInfo('Please create your task type');
                  }
                },
                child: Icon(
                  controller.deleting.value ? Icons.delete : Icons.add,
                ),
              ),
            ),
          );
        },
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Delete Sucessfully');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(
          () => BottomNavigationBar(
            onTap: (int index) => controller.changeTabIndex(index),
            currentIndex: controller.tabIndex.value,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            items: [
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(right: 15.0.wp),
                    child: Icon(Icons.home),
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(left: 15.0.wp),
                    child: Icon(Icons.data_usage),
                  ),
                  label: 'Report'),
            ],
          ),
        ),
      ),
    );
  }
}
