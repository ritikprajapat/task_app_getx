import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app_getx/app/core/utils/extensions.dart';
import 'package:task_app_getx/app/modules/home/home_controller.dart';

import '../../../core/values/colors.dart';

class DoneList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoneList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtrl.doneTodos.isNotEmpty
          ? ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0.wp, horizontal: 5.0.wp),
                  child: Text(
                    'Completed (${homeCtrl.doneTodos.length})',
                    style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
                  ),
                ),
                ...homeCtrl.doneTodos
                    .map(
                      (element) => Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) => homeCtrl.deleteDoneTodo(element),
                        background: Container(
                          color: Colors.red.withOpacity(0.8),
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 5.0.wp),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 2.0.wp,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                              ),
                              Icon(
                                Icons.done,
                                color: blue,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                                child: Text(
                                  element['title'],
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ],
            )
          : Container(),
    );
  }
}
