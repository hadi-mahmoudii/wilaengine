import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Features/CRM/Screens/clients_list_screen.dart';
import '../Features/Home/Screens/home.dart';
import 'Widgets/loading_widget.dart';

class MainScreen extends StatefulWidget {
  // static const route = '/MainScreen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _curIndex = 2;
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      // AppSession.token =
      //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjE0NjRjYWZiODQ0MWYwZTk1NjFlMjJhODM3MDI1YjdjZTdhZDVhNjM4Mjk5MWUyYWM3ZTAwM2RjODUyOWM3NzQ5NWI1MDgzNmZkMDllYzBmIn0.eyJhdWQiOiIxIiwianRpIjoiMTQ2NGNhZmI4NDQxZjBlOTU2MWUyMmE4MzcwMjViN2NlN2FkNWE2MzgyOTkxZTJhYzdlMDAzZGM4NTI5Yzc3NDk1YjUwODM2ZmQwOWVjMGYiLCJpYXQiOjE1OTAyMzc0NzYsIm5iZiI6MTU5MDIzNzQ3NiwiZXhwIjoxNjIxNzczNDc2LCJzdWIiOiI4NTIiLCJzY29wZXMiOltdfQ.K5hg3OOnPyMTpkN6liqlZHYOfyItiIdTjX9gjUsa7x-aM_73VAadvxRVz1XreoqN8gDrWw0yTP7ubaMiUsTuVd1HNbtMlqEToleEmVWcFx5dGtnJdo33LIHdR03eXddXfg3M-GHK8RBakWY40ibP_iZWQt4ADHwC8rv2j1iCSlFrG4Vdrxp2LW-Z63ccOHI5htnJpHcyJM80YLs_gkE0Pp_tsdssDO95DbFkVPFErSN7Ypw4jZddT5HmbeucWwEu-q_g0z2A3jUGjOU9a45FLZoA3a2w2qshGa6t3iuYFgNzTEnA-zYf5Hmir0sz1vhFtqEl1Sv8FXxrRK3-64Occ-w-VyqhyNppfOpf108douWLL3XLeuAYvkihmhgM4gVesr9Y8dGrk3yPBouTf0WAapt2x5xcZUQcupQLhWXI1yEvpvb3ywTZEo9FKv4h9URjhqkOFHj0bdJRi-WT6zjO6dzFiS2YG7fEgp2aUKkIdN-1H4U662bRpL4-V9IIKT0mGuGI57alXj6R9xS7DoAFP2O1s66jhN-YaJLrRMr0xKwXzA_02ADrpZ2YgwxveWWPJo8dX_r-xzCKZtvSERrRhh7wMZrGm28ZzH43OWZC3Bkiv5HBjxsPf9mknc_1Ix80Z2DL1kYKVvZLZn1Sk6uLkhMVtSeC0-9T2pNbJsnZ_f8';
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Color _mainFontColor = _theme.primaryColor;
    return AnnotatedRegion(
      child:
       SafeArea(
        child: Scaffold(
          body: isInit
              ? LoadingWidget(mainFontColor: _mainFontColor)
              : DoubleBackToCloseApp(
                  snackBar: SnackBar(
                    backgroundColor: _mainFontColor,
                    content: Text(
                      'برای خروج دکمه ی بازگشت را مجددا فشار دهید',
                      style: TextStyle(color: Colors.white),
                      textDirection: TextDirection.rtl,
                    ),
                    duration: Duration(seconds: 2),
                  ),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: 5,
                    onPageChanged: (index) {
                      setState(() => _curIndex = index);
                    },
                    itemBuilder: (ctx, pos) {
                      // if (_curIndex == 0) {
                      //   // return ProductsFilterScreen();
                      //   return ProfileMainScreen();
                      // }
                      if (_curIndex == 1) {
                        return ClientListScreen();
                      }
                      if (_curIndex == 2) {
                        return HomeScreen();
                      }
                      
                      
                      else {
                      return Center(
                        child: Center(
                          child: Text(
                            'این صفحه بزودی اضافه خواهد شد . . .',
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      );
                      }
                    },
                  ),
                ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            child: BottomNavigationBar(
              showUnselectedLabels: true,

              selectedLabelStyle: TextStyle(
                        color:  _mainFontColor ,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.clip,


                      ),
               unselectedLabelStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.clip
                      ),

              items: [
                BottomNavigationBarItem(

                  icon: Icon(
                    FontAwesomeIcons.user,
                    color: Colors.grey,
                  ),
                  label: "پروفایل\n",


                  activeIcon: Icon(
                    FontAwesomeIcons.user,
                    color: _mainFontColor,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.user,
                    color: Colors.grey,
                  ),
                  label: "مدیریت ارتباط با مشتری",


                  activeIcon: Icon(
                    FontAwesomeIcons.user,
                    color: _mainFontColor,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/Icons/homeheart.svg',
                    width: 25,
                    height: 25,
                    color: Colors.grey,
                  ),
                  label: "خانه\n",

                  activeIcon: SvgPicture.asset(
                    'assets/Icons/homeheart.svg',
                    width: 25,
                    height: 25,
                    color: _mainFontColor,
                  ),
                ),
              ],
              currentIndex: _curIndex,
              onTap: (index) {
                setState(() => _curIndex = index);
              },
            ),
          ),
        ),
      ),
      value :
       SystemUiOverlayStyle(
        statusBarColor: Color(0xFFc5c5c5),
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }
}
