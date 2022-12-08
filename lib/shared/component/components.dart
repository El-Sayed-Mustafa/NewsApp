import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../cubit/states.dart';

Widget BuildArticleItem(article) => Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        '${article['urlToImage'] ?? 'https://avatars.githubusercontent.com/u/110793510?v=4'}')),
              )),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );

Widget artilceBuilder(list) => ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => BuildArticleItem(list[index]),
          separatorBuilder: (context, index) => Container(
            height: 1,
            color: Colors.grey[300],
          ),
          itemCount: list.length,
        ),
    fallback: (context) => Center(child: CircularProgressIndicator()));
