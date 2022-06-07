// Read

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Config/app_session.dart';
import '../Models/media.dart';
import '../Models/request_status.dart';
import 'loading_widget.dart';

class FileAddButton extends StatelessWidget {
  final Function cameraFunction;
  final Function galeryFunction;
  final controller;
  const FileAddButton({
    Key key,
    @required this.controller,
    this.cameraFunction,
    this.galeryFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (controller.newFilesLoadingStatus == RequestStatus.stable)
          showDialog(
            context: context,
            builder: (
              ctx,
            ) =>
                AlertDialog(
              contentPadding: EdgeInsets.all(1),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      if (cameraFunction != null) cameraFunction();
                      // Navigator.of(context).pushNamed(
                      //   Routes.captureImageScreen,
                      //   arguments: cameraAsset,
                      // );
                    },


                    child : Container(
                      width: double.infinity,
                      child: Text(
                        'دوربین',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 4 * AppSession.deviceBlockSize,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.of(ctx).pop();
                      if (galeryFunction != null) galeryFunction();
                      // await loadAssets(context);
                    },
                    child:  Container(
                      width: double.infinity,
                      child: Text(
                        'گالری',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 4 * AppSession.deviceBlockSize,
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
            color: Color(0XFF707070),
          ),
          color: Color(0XFFF1F1F1),
        ),
        width: 100,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: controller.newFilesLoadingStatus ==
                RequestStatus.stable // check new files are uploading or not
            ? Icon(
                FontAwesomeIcons.plus,
                color: Color(0XFF707070),
                size: 11 * AppSession.deviceBlockSize,
              )
            : Center(
                child: LoadingWidget(
                  mainFontColor: AppSession.mainFontColor,
                ),
              ),
      ),
    );
  }
}

class SaveBTN extends StatefulWidget {
  final controller;
  SaveBTN({@required this.controller});

  @override
  _SaveBTNState createState() => _SaveBTNState();
}

class _SaveBTNState extends State<SaveBTN> {
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0xFF32CAD5),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.bottomLeft,
      child: InkWell(
        onTap: () {
          if (widget.controller.isUpdating == RequestStatus.stable)
            widget.controller.updateTask(context);
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF32CAD5),
          ),
          child: Center(
            child: widget.controller.isUpdating == RequestStatus.loading
                ? LoadingWidget(mainFontColor: Colors.white)
                : Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 12 * AppSession.deviceBlockSize,
                  ),
          ),
        ),
      ),
    );
  }
}

class ImageShowBox extends StatelessWidget {
  final MediaModel media;
  final Function deleteFunction;
  const ImageShowBox({
    Key key,
    @required this.media,
    @required this.deleteFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          contentPadding: EdgeInsets.all(0),
          content: InteractiveViewer(
            child: media.file != null
                ? Image.file(
                    media.file,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    media.url,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Color(0XFF707070),
          ),
        ),
        width: 100,
        child: Stack(
          children: [
            Container(
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: media.file != null
                    ? Image.file(
                        media.file,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        media.url,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: InkWell(
                onTap: () async {
                  deleteFunction();
                },
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0XFFF1F1F1),
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
    );
  }
}
