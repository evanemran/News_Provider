import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_provider/data/data_provider.dart';
import 'package:news_provider/listeners/response_listener.dart';
import 'package:news_provider/network/network_manager.dart';
import 'package:news_provider/widgets/news_widget_horizontal.dart';

import '../models/news_model.dart';
import '../widgets/news_widget_image.dart';
import '../widgets/news_widget_vertical.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> implements ResponseListener<List<NewsModel>>{

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
          (_) {
        if (ref.watch(topHeadlines).isEmpty) {
          _getTopHeadlines("us", "general");
        }
      },
    );

    super.initState();
  }

  String selectedCategory = "GENERAL";
  bool isLoading = true;

  final List<String> categories = [
    'GENERAL',
    'BUSINESS',
    'SPORTS',
    'ENTERTAINMENT',
    'HEALTH',
    'SCIENCE',
    'TECHNOLOGY',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Provider", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                return Wrap(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: InkWell(
                      onTap: () {
                        // Handle category selection
                        setState(() {
                          selectedCategory = categories[index];
                          isLoading = true;
                          _getTopHeadlines("us", selectedCategory.toLowerCase());
                        });
                        print('Selected category: ${categories[index]}');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: categories[index] == selectedCategory ? Colors.black : Colors.red, // Change color as needed
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(categories[index], style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),),
                        ),
                      ),
                    ),
                  )
                ],);
              },
            ),
          ),
          if(isLoading) ...{
            const Center(child: LinearProgressIndicator(color: Colors.red,),)
          }
          else ...{
            ref.watch(topHeadlines).isEmpty
                ? const SizedBox()
                : Expanded(child: ListView.builder(
                itemCount: ref.watch(topHeadlines).length,
                itemBuilder: (context, position) {
                  var random = 0;
                  if (position % 3 == 0) {
                    random = 1;
                  } else if (position % 4 == 0) {
                    random = 3;
                  } else {
                    random = 2;
                  }

                  if(random == 2) {
                    return NewsWidgetHorizontal(model: ref.watch(topHeadlines)[position]);
                  }
                  else if (random == 3) {
                    return NewsWidgetImage(model: ref.watch(topHeadlines)[position]);
                  }
                  else if (random == 1) {
                    return NewsWidgetVertical(model: ref.watch(topHeadlines)[position]);
                  }
                }
            )),
          }
        ],
      )
    );
  }

  void _getTopHeadlines(String country, String category) {
    RequestManager().getHeadlines(country, category, this);
  }


  @override
  void onError(String message) {
    // TODO: implement onError
  }

  @override
  void onSuccess(List<NewsModel> data, String message) {
    ref.read(topHeadlines.notifier).state = data;
    setState(() {
      isLoading = false;
    });
  }

  ProviderListenable getProvider() {
    if(selectedCategory == "GENERAL") {
      return topHeadlines;
    }
    else if (selectedCategory == "BUSINESS") {
      return topHeadlinesBusiness;
    }
    else if (selectedCategory == "SPORTS") {
      return topHeadlinesSports;
    }
    else if (selectedCategory == "ENTERTAINMENT") {
      return topHeadlinesEntertainment;
    }
    else if (selectedCategory == "HEALTH") {
      return topHeadlinesHealth;
    }
    else if (selectedCategory == "SCIENCE") {
      return topHeadlinesScience;
    }
    else if (selectedCategory == "TECHNOLOGY") {
      return topHeadlinesTechnology;
    }
    else {
      return topHeadlines;
    }
  }
}
