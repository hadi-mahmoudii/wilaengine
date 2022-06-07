import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Config/routes.dart';
import '../../../Cores/Entities/global.dart';
import '../../../Cores/Models/media_old.dart';
import '../../../Cores/Widgets/header3.dart';
import '../../../Cores/Widgets/screens_header.dart';
import '../Models/client_task_object.dart';
import '../Models/user_details_object.dart';
import '../Widgets/task_details_widgets.dart';

class TaskDetailsScreen extends StatefulWidget {
  @override
  _TaskDetailsScreenState createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  ClientTaskModel task;
  bool isInit = true;
  List<Map<String, Object>> files = [];
  List<File> addFiles = [];
  bool isLoading = false;
  int newFilesCounter = 0;
  // List<File> addFiles = [];
  final String batchId = randomString(50);
  Future<void> cameraAsset(var file) async {
    GlobalEntity gl = new GlobalEntity();
    files.removeWhere((element) => element['id'] == 'add');
    files.add({
      'id': 'loading',
      'url': 'loading',
      'file': file.readAsBytesSync(),
      'isNewFile': true
    });
    setState(() {});
    MediaObject media = await gl.addImage(
      batchId,
      await file.length() > 3000000
          ? await gl.compressImage(file)
          : file.readAsBytesSync(),
    );
    files.removeWhere((element) => element['id'] == 'loading');
    files.add({
      'id': media.id,
      'url': media.url,
      'file': file.readAsBytesSync(),
      'isNewFile': true
    });
    files.add({'id': 'add', 'url': 'add', 'file': '', 'isNewFile': true});
    newFilesCounter += 1;
    setState(() {});
  }

  Future<void> loadAssets(BuildContext context) async {
    try {
      var fls = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'bmp', 'jpeg'],
      ))as List<File>;
      GlobalEntity gl = new GlobalEntity();
      for (var file in fls) {
        //be ezaye har file yek file khali ba id dar hale load ezafe mishavad ta
        //dar bakhshe namayesh box loading be karbar namayesh dade shavad.
        //pas az uploade aks in file khali hazf shode va file asli gharar migirad.
        files.removeWhere((element) => element['id'] == 'add');
        files.add({
          'id': 'loading',
          'url': 'loading',
          'file': file.readAsBytesSync(),
          'isNewFile': true
        });
        setState(() {});
        MediaObject media = await gl.addImage(
          batchId,
          await file.length() > 3000000
              ? await gl.compressImage(file)
              : file.readAsBytesSync(),
        );
        files.removeWhere((element) => element['id'] == 'loading');
        files.add({
          'id': media.id,
          'url': media.url,
          'file': file.readAsBytesSync(),
          'isNewFile': true
        });
        files.add({'id': 'add', 'url': 'add', 'file': '', 'isNewFile': true});
        newFilesCounter += 1;
        setState(() {});
        // addFiles.add(file);
      }
    } catch (_) {}
  }

  // Future<void> loadAssets(BuildContext context) async {
  //   try {
  //     var fls = await FilePicker.getMultiFile(
  //       type: FileType.custom,
  //       allowedExtensions: ['jpg', 'png', 'bmp', 'jpeg'],
  //     );

  //     setState(() {
  //       for (var file in fls) {
  //         files.add({'file': file.readAsBytesSync(), 'isNewFile': true});
  //         addFiles.add(file);
  //       }
  //     });
  //   } catch (_) {}
  // }

  @override
  void didChangeDependencies() async {
    if (isInit) {
      ClientTaskOverviewModel overviewTask =
          (ModalRoute.of(context).settings.arguments as List<Object>)[0];
      // task = await TasksEntity().getSingleTaskDetails(overviewTask.id);
      files = await GlobalEntity().downloadMedias(task.medias);
      files.add({'id': 'add', 'url': 'add', 'file': '', 'isNewFile': true});
      setState(() {
        isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ClientDetailsModel user =
        (ModalRoute.of(context).settings.arguments as List<Object>)[1];
    ClientTaskOverviewModel overviewTask =
        (ModalRoute.of(context).settings.arguments as List<Object>)[0];
    return Scaffold(
      body: isInit
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: <Widget>[
                GlobalScreensHeader(
                  backLabel: 'لیست خدمات',
                  eName: 'DETAILS',
                  pName: 'جزئیات خدمت',
                  icon: Icons.format_align_left,
                ),
                SizedBox(height: 10),
                FourTopButtons(
                  task: task,
                  user: user,
                ),
                RowReport(
                  label: 'مسئول انجام',
                  details: task.user,
                  // details: 'دکتر علی موسوی',
                  icon: Icons.person,
                  fontSize: 4,
                ),
                RowReport(
                  label: 'زمان انجام',
                  details: task.eDate,
                  icon: Icons.watch_later,
                  fontSize: 4,
                ),
                RowReport(
                  label: 'توضیحات خدمت',
                  details: task.details,
                  // 'این تراکنش برای انجام کار لیزر به صورت نصف نقد و نصف کارت به کارت انجام شد',
                  icon: Icons.format_quote,
                  fontSize: 4,
                ),
                SizedBox(height: 30),
                SimpleHeader3(
                    persian: 'فایل ها', english: 'FILES', icon: Icons.cloud),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Divider(),
                ),
                files.length == 0
                    ? Container()
                    : Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        padding: EdgeInsets.only(top: 20),
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (ctx, ind) => files[ind]['id'] == 'add'
                              ? InkWell(
                                  onTap: () async {
                                    showDialog(
                                      context: context,
                                      builder: (
                                        ctx,
                                      ) =>
                                          AlertDialog(
                                        contentPadding: EdgeInsets.all(1),
                                        content: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                                Navigator.of(context).pushNamed(
                                                  Routes.captureImageScreen,
                                                  arguments: cameraAsset,
                                                );
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                child: Text(
                                                  'دوربین',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    fontSize: 4 *
                                                        AppSession
                                                            .deviceBlockSize,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            TextButton(
                                              onPressed: () async {
                                                Navigator.of(ctx).pop();
                                                await loadAssets(context);
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                child: Text(
                                                  'گالری',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    fontSize: 4 *
                                                        AppSession
                                                            .deviceBlockSize,
                                                  ),
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color(0xFFE3E3E3),
                                      ),
                                    ),
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 20,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.grey,
                                      size: 10 * AppSession.deviceBlockSize,
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () => showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      contentPadding: EdgeInsets.all(0),
                                      content: InteractiveViewer(
                                        child: Image.memory(
                                          files[ind]['file'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        height: double.infinity,
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: Color(0xFFE3E3E3),
                                          ),
                                        ),
                                        child: files[ind]['id'] == 'loading'
                                            ? Container(
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 20),
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : Image.memory(
                                                files[ind]['file'],
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: InkWell(
                                          onTap: () async {
                                            await GlobalEntity()
                                                .removeImage(files[ind]['id']);
                                            setState(() {
                                              if (newFilesCounter != 0)
                                                newFilesCounter -= 1;
                                              files.removeAt(ind);
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                            child: Icon(
                                              Icons.close,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          itemCount: files.length,
                        ),
                      ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(width: 25),
                      // FloatingActionButton(
                      //   onPressed: () async {
                      //     await loadAssets(context);
                      //   },
                      //   // decoration: BoxDecoration(),
                      //   // margin: EdgeInsets.only(left: AppSession.deviceWidth * .1),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: Color(0xFF32CAD5).withOpacity(.5),
                      //           spreadRadius: 1,
                      //           blurRadius: 6,
                      //           offset: Offset(0, 3),
                      //         ),
                      //       ],
                      //     ),
                      //     alignment: Alignment.bottomLeft,
                      //     child: CircleAvatar(
                      //       radius: 8 * AppSession.deviceBlockSize,
                      //       backgroundColor: Color(0xFF32CAD5),
                      //       child: Icon(
                      //         Icons.add,
                      //         color: Colors.white,
                      //         size: 15 * AppSession.deviceBlockSize,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(width: 5),
                      // newFilesCounter == 0
                      //     ? Container()
                      //     : FloatingActionButton(
                      //         onPressed: () async {},
                      //         child: Container(
                      //           decoration: BoxDecoration(
                      //             shape: BoxShape.circle,
                      //             boxShadow: [
                      //               BoxShadow(
                      //                 color: Colors.green.withOpacity(.5),
                      //                 spreadRadius: 1,
                      //                 blurRadius: 6,
                      //                 offset: Offset(0, 3),
                      //               ),
                      //             ],
                      //           ),
                      //           alignment: Alignment.bottomLeft,
                      //           child: SaveBTN(
                      //             task: overviewTask,
                      //             user: user,
                      //             batchId: batchId,
                      //           ),
                      //         ),
                      //       ),
                    ],
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 25),
                //   child: GridView.builder(
                //     physics: NeverScrollableScrollPhysics(),
                //     shrinkWrap: true,
                //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 3,
                //       crossAxisSpacing: 10,
                //       mainAxisSpacing: 10,
                //     ),
                //     itemBuilder: (ctx, ind) => GestureDetector(
                //       onTap: () => showDialog(
                //         context: context,
                //         builder: (ctx) => AlertDialog(
                //           contentPadding: EdgeInsets.all(0),
                //           content: Image.memory(
                //             files[ind]['file'],
                //             fit: BoxFit.cover,
                //           ),
                //         ),
                //       ),
                //       child: Stack(
                //         children: <Widget>[
                //           Container(
                //             height: double.infinity,
                //             padding: EdgeInsets.all(5),
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(5),
                //               border: Border.all(
                //                 color: Color(0xFFE3E3E3),
                //               ),
                //             ),
                //             child: Image.memory(
                //               files[ind]['file'],
                //               fit: BoxFit.cover,
                //             ),
                //           ),
                //           Positioned(
                //               top: 0,
                //               right: 0,
                //               child: InkWell(
                //                 onTap: () {
                //                   setState(() {
                //                     files.removeAt(ind);
                //                   });
                //                 },
                //                 child: Container(
                //                   padding: EdgeInsets.all(1),
                //                   decoration: BoxDecoration(
                //                     shape: BoxShape.circle,
                //                     color: Colors.white,
                //                   ),
                //                   child: Icon(
                //                     Icons.close,
                //                   ),
                //                 ),
                //               )),
                //         ],
                //       ),
                //     ),
                //     itemCount: files.length,
                //   ),
                // ),

                // Container(
                //   padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                //   child: Row(
                //     children: <Widget>[
                //       InkWell(
                //         onTap: () async {
                //           await loadAssets(context);
                //         },
                //         child: CircleAvatar(
                //           radius: 8 * AppSession.deviceBlockSize,
                //           backgroundColor: Color(0xFF32CAD5),
                //           child: Icon(
                //             Icons.add,
                //             color: Colors.white,
                //             size: 15 * AppSession.deviceBlockSize,
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         width: 5,
                //       ),
                //       InkWell(
                //         onTap: () async {
                //           if (isLoading) {
                //           } else {
                //             setState(() {
                //               isLoading = true;
                //             });
                //             showDialog(
                //                 barrierDismissible: false,
                //                 context: context,
                //                 builder: (ctx) => AlertDialog(
                //                       content: SizedBox(
                //                         height: 100,
                //                         width: 100,
                //                         child: Center(
                //                           child: CircularProgressIndicator(),
                //                         ),
                //                       ),
                //                     ));
                //             GlobalEntity()
                //                 .taskAddFiles(task, addFiles)
                //                 .then((result) {
                //               Navigator.of(context).pop();
                //               Navigator.of(context).popAndPushNamed(
                //                   Routes.taskDetailsScreen,
                //                   arguments: [overviewTask, user]);
                //               showDialog(
                //                 context: context,
                //                 builder: (ctx) => Directionality(
                //                   textDirection: TextDirection.rtl,
                //                   child: AlertDialog(
                //                     title: Text(result ? 'موفقیت' : 'خطا'),
                //                     content: Text(
                //                       result
                //                           ? 'فایل های جدید با موفقیت اضافه شد'
                //                           : 'خطا در اضافه کردن فایل!',
                //                     ),
                //                     actions: <Widget>[
                //                       FlatButton(
                //                           onPressed: () async {
                //                             Navigator.of(ctx).pop();
                //                           },
                //                           child: Text('Ok'))
                //                     ],
                //                   ),
                //                 ),
                //               );
                //             });
                //           }
                //         },
                //         child: CircleAvatar(
                //           radius: 8 * AppSession.deviceBlockSize,
                //           backgroundColor: Colors.green,
                //           child: Icon(
                //             Icons.save,
                //             color: Colors.white,
                //             size: 12 * AppSession.deviceBlockSize,
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // )
              ],
            ),
    );
  }
}
