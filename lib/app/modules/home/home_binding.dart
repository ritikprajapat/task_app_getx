import 'package:get/get.dart';
import 'package:task_app_getx/app/data/providers/task/provider.dart';
import 'package:task_app_getx/app/data/services/storage/repository.dart';
import 'package:task_app_getx/app/modules/home/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
