import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
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
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (currentIndex == 1)
      getSports();
    else if (currentIndex == 2)
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
      business = value?.data['articles'];
      emit(NewGetBusinessSuccessState());
    }).catchError((error) {
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
      sports = value?.data['articles'];
      emit(NewGetBusinessSuccessState());
    }).catchError((error) {
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
      science = value?.data['articles'];
      emit(NewGetScienceSuccessState());
    }).catchError((error) {
      emit(NewGetScienceErrorState(error.toString()));
    });
  }

  List<dynamic> search = [];

  void searchList(String value) {
    emit(NewsSearchLoadingState());

    DioHelper.getData(url: 'v2/everything', query: {
      'q': value,
      'apiKey': '8714374f5bdd43cea493fe8bdd1579c8'
    }).then((value) {
      search = value?.data['articles'];
      print(search[0]['title']);
      emit(NewGetSearchSuccessState());
    }).catchError((error) {
      emit(NewGetSearchErrorState(error.toString()));
    });
  }
}
