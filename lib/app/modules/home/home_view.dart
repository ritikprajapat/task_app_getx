import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app_getx/app/core/utils/extensions.dart';
import 'package:task_app_getx/app/data/models/task.dart';
import 'package:task_app_getx/app/modules/home/home_controller.dart';
import 'widgets/add_cart.dart';
import 'widgets/task_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
            Obx(() => GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: [
                    ...controller.tasks
                        .map(
                          (element) => TaskCard(
                            task: element,
                          ),
                        )
                        .toList(),
                    AddCart(),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
