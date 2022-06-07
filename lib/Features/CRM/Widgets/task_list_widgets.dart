import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Config/routes.dart';
import '../Models/user_details_object.dart';

class SearchUserBox extends StatelessWidget {
  final TextEditingController ctrl;
  final Function function;

  const SearchUserBox({
    Key key,
    @required this.ctrl,
    @required this.function,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          controller: ctrl,
          // onChanged: (value) {
          //   var appSession = Provider.of<AppSession>(context, listen: false);
          //   List<ClientOverviewModel> allUsers = appSession.allUsers;
          //   List<ClientOverviewModel> currentUsers = [];
          //   for (ClientOverviewModel user in allUsers) {
          //     if (user.name.contains(value) || user.phone.contains(value)) {
          //       currentUsers.add(user);
          //     }
          //   }
          //   appSession.setCurrentUsers(currentUsers);
          // },
          decoration: InputDecoration(
            labelText: 'جست و جو بر اساس نام مشتری',
            labelStyle: TextStyle(fontSize: 3 * AppSession.deviceBlockSize),
            suffixIcon: InkWell(
              onTap: function,
              child: Icon(
                FontAwesomeIcons.search,
              ),
            ),
            isDense: true,
          ),
          style: TextStyle(fontSize: 5 * AppSession.deviceBlockSize),
          keyboardType: TextInputType.text,
        ),
      ),
    );
  }
}

class UserRowNavigator extends StatelessWidget {
  final Color mainColor;
  final borderColor;
  final ClientOverviewModel user;

  const UserRowNavigator({
    Key key,
    this.mainColor,
    this.borderColor,
    @required this.user,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        Routes.clientDetailsScreen,
        arguments: user.id,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: mainColor != null ? mainColor.withOpacity(.5) : null,
          border: Border(
            bottom: BorderSide(
              color: borderColor != null
                  ? borderColor
                  : Theme.of(context).canvasColor,
            ),
            top: BorderSide(
              color: borderColor != null
                  ? borderColor
                  : Theme.of(context).canvasColor,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.more_vert,
                size: 10 * AppSession.deviceBlockSize,
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).pushNamed(
                Routes.sendMessageScreen,
                arguments: user,
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFEB5E00).withOpacity(.5),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Color(0xFFEB5E00),
                  radius: 5 * AppSession.deviceBlockSize,
                  child: Icon(
                    Icons.message,
                    color: Colors.white,
                    size: 6 * AppSession.deviceBlockSize,
                  ),
                ),
              ),
            ),
            // Spacer(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    user.name,
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  user.phone == '-'
                      ? user.nameEn != ''
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    user.nameEn,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 3 * AppSession.deviceBlockSize,
                                      fontFamily: 'montserrat',
                                    ),
                                    textDirection: TextDirection.rtl,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                  size: 3.5 * AppSession.deviceBlockSize,
                                ),
                              ],
                            )
                          : Container()
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                user.phone,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 3 * AppSession.deviceBlockSize,
                                  fontFamily: 'montserrat',
                                ),
                                textDirection: TextDirection.rtl,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Icon(
                              Icons.call,
                              color: Colors.grey,
                              size: 3.5 * AppSession.deviceBlockSize,
                            ),
                          ],
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserRowNavigatorPlaceHolder extends StatelessWidget {
  const UserRowNavigatorPlaceHolder({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).canvasColor,
          ),
          // top: BorderSide(
          //   color: Theme.of(context).canvasColor,
          // ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.more_vert,
              size: 10 * AppSession.deviceBlockSize,
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFEB5E00).withOpacity(.5),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: CircleAvatar(
                backgroundColor: Color(0xFFEB5E00),
                radius: 5 * AppSession.deviceBlockSize,
                child: Icon(
                  Icons.message,
                  color: Colors.white,
                  size: 6 * AppSession.deviceBlockSize,
                ),
              ),
            ),
          ),
          // Spacer(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 200,
                  height: 15.0,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        width: 100,
                        height: 12.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Icon(
                      Icons.call,
                      color: Colors.black,
                      size: 3.5 * AppSession.deviceBlockSize,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
