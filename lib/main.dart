import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/cubit/AppStates.dart';
import 'package:news_app/cubit/app_cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/shared/observer/observer.dart';

import 'cubit/cubit.dart';
import 'layout/news_layout.dart';
import 'network/local/cash_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();

  bool? isDark = CashHelper.getData(key: 'isDark');

  runApp( MyApp(isDark!));
}

class MyApp extends StatelessWidget {

   bool isDark ;

  MyApp(this.isDark);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit()..changeAppMode(
        fromShared: isDark,
      ),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder:(context, state) {
          return  MaterialApp(
            theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0,
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  elevation: 20,
                ),
                textTheme:const TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,
                        fontWeight:  FontWeight.w600,
                        color: Colors.black
                    )
                )

            ),
            darkTheme: ThemeData(
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: const Color.fromARGB(30,11,16,255),
                appBarTheme: const AppBarTheme(
                  backwardsCompatibility: false,
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Color.fromARGB(28, 32, 47, 255),
                      statusBarIconBrightness: Brightness.light
                  ),
                  backgroundColor: Color.fromARGB(10,11,16,255)
                  ,

                  elevation: 0,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: const Color.fromARGB(1,11,16,255)
                  ,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey[400],
                  elevation: 20,
                ),
                textTheme:const TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,
                        fontWeight:  FontWeight.w600,
                        color: Colors.white
                    )
                )
            ),
            themeMode: AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light ,
            debugShowCheckedModeBanner: false,
            home: const NewsLayout(),
          );
        }

      ),
    );
  }
}