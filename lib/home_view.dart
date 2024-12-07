import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_practi/home_controller.dart';

class HomeView extends StatelessWidget {
  static const id = "home_view";
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController comments = TextEditingController();

    var controller = Get.put(HomeController());
    void updateProvider(int id) {
      return controller.updateData(
          id: id, name: name.text, comments: comments.text);
    }

    deleteProvider(int id) {
      controller.deleteData(id);
    }

    return Scaffold(body: Obx(() {
      if (controller.serviceProvider.isEmpty) {
        return Center(child: CircularProgressIndicator());
      } else {
        return ListView.builder(
          itemCount: controller.serviceProvider.length,
          itemBuilder: (context, index) {
            final item = controller.serviceProvider[index];
            return ListTile(
              leading: Text(item["id"].toString()),
              title: Text(item["name"].toString()),
              subtitle: Text(item["created_at"].toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () => deleteProvider(item["id"]),
                      icon: Icon(Icons.delete)),
                  IconButton(
                      onPressed: () {
                        name.text = item["name"] ?? "";
                        comments.text = item["comments"] ?? "";
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text("data"),
                                  content: Column(
                                    children: [
                                      TextField(
                                        controller: name,
                                        decoration: InputDecoration(
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                      ),
                                      TextField(
                                        controller: comments,
                                        decoration: InputDecoration(
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          updateProvider(item["id"]);
                                          Navigator.pop(context);
                                        },
                                        child: Text("done"))
                                  ],
                                ));
                      },
                      icon: Icon(Icons.edit))
                ],
              ),
            );
          },
        );
      }
    }));
  }
}
