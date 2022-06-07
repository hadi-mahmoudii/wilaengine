import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:willaEngine/Features/CRM/Screens/client_more_details_Screen.dart';
import 'package:willaEngine/Features/CRM/Screens/client_update_screen.dart';
import 'package:willaEngine/Features/CRM/Screens/client_update_task_screen.dart';


import 'Cores/Config/app_session.dart';
import 'Cores/Config/routes.dart';
import 'Cores/Entities/camera.dart';
import 'Cores/main-screen.dart';
import 'Cores/splash_screen.dart';
import 'Features/Auth/Screens/forget_pass_screen.dart';
import 'Features/Auth/Screens/login_screen.dart';
import 'Features/Auth/Screens/register_verify.dart';
import 'Features/Auth/Screens/repass_screen.dart';
import 'Features/Auth/Screens/signup_screen.dart';
import 'Features/CRM/Screens/client_add_screen.dart';
import 'Features/CRM/Screens/client_add_task_screen.dart';
import 'Features/CRM/Screens/client_details_screen.dart';
import 'Features/CRM/Screens/client_file_screen.dart';
import 'Features/CRM/Screens/client_info_screen.dart';
import 'Features/CRM/Screens/client_task_details_screen.dart';
import 'Features/CRM/Screens/client_tasks_screen.dart';
import 'Features/CRM/Screens/client_transaction_details_screen.dart';
import 'Features/CRM/Screens/client_transactions_screen.dart';
import 'Features/CRM/Screens/clients_list_screen.dart';
import 'Features/Comment/Screens/comments_screen.dart';
import 'Features/Message/Screens/messages_list_screen.dart';
import 'Features/Message/Screens/send_message_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
    
          debugShowCheckedModeBanner: false,
          title: 'Kaman cable',
          theme: ThemeData(
            primaryColor: Colors.black,
            accentColor: Color(0xFFEE3552),
            // Color(0xFF495065)
            fontFamily: 'iranyekan',
            canvasColor: Color(0xFFF9F9F9),
            hoverColor: Colors.blue,
            
            // cursorColor: Color.fromRGBO(0x1B, 0x27, 0x49, 1),
            disabledColor: Colors.black54,
            // primaryTextTheme: TextTheme(
            //   body1: TextStyle(
            //     color: Colors.black,
            //   ),
            // ),
          ),
          getPages: [
            GetPage(name: Routes.mainScreen, page: () =>MainScreen() ),
            GetPage(name: Routes.loginScreen, page: ()=> LoginScreen()),
            GetPage(name: Routes.registerScreen, page: ()=> SignupScreen()),
            GetPage(name: Routes.forgetPassScreen, page: ()=> ForgetPassScreen()),
            GetPage(name: Routes.rePassScreen, page: ()=> RePassScreen()),
            GetPage(name: Routes.registerVerify, page: ()=> RegisterVerifyScreen()),
            GetPage(name: Routes.clientListScreen, page: ()=> ClientListScreen()),
            GetPage(name: Routes.clientDetailsScreen, page: ()=>ClientDetailsScreen() ),
            GetPage(name: Routes.clientMoreDetailsScreen, page: ()=> ClientMoreDetailsScreen()),
            GetPage(name: Routes.clientInfoScreen, page: ()=>  ClientInfoScreen() ),
            GetPage(name: Routes.addClientScreen, page: ()=> AddClientScreen()),
            GetPage(name: Routes.updateClientScreen, page: ()=> UpdateClientScreen()),
            GetPage(name: Routes.clientFileScreen, page: ()=> ClientFileScreen()),
            GetPage(name: Routes.transactionDetailsScreen, page: ()=>ClientTransactionDetailsScreen() ),
            GetPage(name: Routes.transactionsListScreen, page: ()=> ClientTransactionsScreen()),
            GetPage(name: Routes.commentsScreen, page: ()=> CommentsScreen()),
            GetPage(name: Routes.messagesScreen, page: ()=>MessagesListScreen()),
            GetPage(name: Routes.sendMessageScreen, page: ()=> SendMessageScreen()),
            GetPage(name: Routes.clientTasksScreen, page: ()=>ClientTasksScreen()),
            GetPage(name: Routes.addTaskScreen, page: ()=> ClientAddTaskScreen()),
            GetPage(name:  Routes.updateTaskScreen, page: ()=> ClientUpdateTaskScreen()),
            GetPage(name: Routes.clienttaskDetailsScreen, page: ()=> ClientTaskDetailsScreen()),

            GetPage(name: Routes.captureImageScreen, page: ()=> CaptureImage()),
          
          ],
          
          home: SplashScreen()
          //  MainScreen()
          // Simple_splashscreen(
          //   context: context,
          //   gotoWidget: LoginScreen(),
          //   splashscreenWidget: SplashScreen(),
          //   timerInSeconds: 3,
          // ),
          
    );
  }
}
