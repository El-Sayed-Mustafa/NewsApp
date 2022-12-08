import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/AppStates.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(NewsInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = true;

  void changeAppMode(){
    isDark = !isDark;
    emit(NewsChangeModeAppState());
  }


}
