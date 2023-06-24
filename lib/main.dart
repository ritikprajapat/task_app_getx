import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_app_getx/app/data/services/storage/services.dart';
import 'package:task_app_getx/app/modules/home/home_view.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task App using Getx',
      home: const HomeView(),
    );
  }
}