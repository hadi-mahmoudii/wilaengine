import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Config/routes.dart';
import '../../../Cores/Widgets/image_widgets.dart';
import '../../../Cores/Widgets/screens_header.dart';
import '../controller/Client_file.dart';

// class ClientFileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<ClientFileProvider>(
//       create: (_) =>
//           ClientFileProvider(user: ModalRoute.of(context).settings.arguments),
//       child: ClientFileTile(),
//     );
//   }
// }

// class ClientFileScreen extends StatefulWidget {
//   const ClientFileScreen({
//     Key key,
//   }) : super(key: key);

//   @override
//   _ClientFileScreenState createState() => _ClientFileScreenState();
// }

class ClientFileScreen extends StatelessWidget {
  ClientFileController clientFileController =
      Get.put(ClientFileController(user: Get.arguments));
  @override
  Widget build(BuildContext context) {
    return GetX<ClientFileController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            child: GlobalScreensHeader(
              backLabel: controller.user.name,
              eName: 'Files',
              pName: 'فایل ها',
              icon: Icons.cloud,
            ),
            preferredSize: Size(
              double.infinity,
              AppSession.deviceHeigth * 0.155,
            ),
          ),
          body: ListView(
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                padding: EdgeInsets.only(top: 20),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (ctx, ind) => controller.images[ind].type == 'add'
                      ? FileAddButton(
                          controller: controller,
                          galeryFunction: () async =>
                              await controller.addImages(context, [], true),
                          cameraFunction: () => Navigator.of(context).pushNamed(
                            Routes.captureImageScreen,
                            arguments: controller.addImages,
                          ),
                        )
                      : Container(
                          height: 100,
                          child: ImageShowBox(
                            media: controller.images[ind],
                            deleteFunction: () {
                              controller.removeImage(
                                  context, controller.images[ind]);
                            },
                          ),
                        ),
                  itemCount: controller.images.length,
                ),
              ),
              SizedBox(height: 75),
            ],
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(right: AppSession.deviceWidth - 150),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(width: 25),
                controller.newImages == 0
                    ? Container()
                    : FloatingActionButton(
                        onPressed: () async {},
                        child: SaveBTN(
                          controller: controller,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
