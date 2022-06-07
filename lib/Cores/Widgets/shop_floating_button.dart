import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import '../../Features/UserCard/Screens/user-card-list-screen.dart';

class ShopFloatingButton extends StatelessWidget {
  const ShopFloatingButton({
    Key key,
    @required double deviceWidthBlockSize,
    @required double deviceHeightBlockSize,
  }) : super(key: key);

  final String count = '6';
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        // color:Colors.red,
        margin: EdgeInsets.only(left: 30),
        width: 80,
        height: 80,
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 50,
              // left: 11 * _deviceWidthBlockSize,
              right: 0,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: _theme.accentColor,
                child: Text(
                  count,
                  style: TextStyle(
                    color: _theme.primaryColor,
                    // fontSize: 14,
                    fontFamily: 'montserrat',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 5,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  // Navigator.pushNamed(context, UserCardListScreen.route);
                  // showDialog(
                  //   context: context,
                  //   builder: (ctx) => AlertDialog(
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.all(
                  //         Radius.circular(10.0),
                  //       ),
                  //     ),
                  //     content: OptionsDialog(),
                  //     contentPadding: EdgeInsets.symmetric(vertical: 20),
                  //   ),
                  // );
                },
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).accentColor,
                  radius: 30,
                  child: SvgPicture.asset(
                    'assets/Icons/shop.svg',
                    color: _theme.primaryColor,
                    width: 30,
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
