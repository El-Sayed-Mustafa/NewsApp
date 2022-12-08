import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/shared/component/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = NewsCubit.get(context).business;
          return ConditionalBuilder(
              condition: state is! NewsGetBusinessLoadingState,
              builder: (context) => ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        BuildArticleItem(list[index]),
                    separatorBuilder: (context, index) => Container(
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    itemCount: list.length,
                  ),
              fallback: (context) =>
                  Center(child: CircularProgressIndicator()));
        });
  }
}
