import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sittings_screen/sittings_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';

import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
    const SittingsScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports_football,
      ),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if(currentIndex == 1)
      getSports();
    else if (currentIndex==2)
      getScience();
    else
      getBusiness();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {

    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '8714374f5bdd43cea493fe8bdd1579c8'
    }).then((value) {
      // print(value?.data.toString());
      business = value?.data['articles'];
      print(business[0]['title']);
      emit(NewGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {

    emit(NewsGetSportsLoadingState());

    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'sports',
      'apiKey': '8714374f5bdd43cea493fe8bdd1579c8'
    }).then((value) {
      // print(value?.data.toString());
      sports = value?.data['articles'];
      print(sports[0]['title']);
      emit(NewGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewGetSportsErrorState(error.toString()));
    });
  }

  List<dynamic> science = [];

  void getScience() {

    emit(NewsGetScienceLoadingState());

    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'science',
      'apiKey': '8714374f5bdd43cea493fe8bdd1579c8'
    }).then((value) {
      // print(value?.data.toString());
      science = value?.data['articles'];
      print(science[0]['title']);
      emit(NewGetScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewGetScienceErrorState(error.toString()));
    });
  }
}
