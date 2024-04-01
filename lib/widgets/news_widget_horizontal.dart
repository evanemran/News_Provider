import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_provider/models/news_model.dart';

class NewsWidgetHorizontal extends StatefulWidget {
  const NewsWidgetHorizontal({super.key, required this.model});

  final NewsModel model;

  @override
  State<NewsWidgetHorizontal> createState() => _NewsWidgetHorizontalState();
}

class _NewsWidgetHorizontalState extends State<NewsWidgetHorizontal> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(8,4,8,4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.model.urlToImage.toString(),
                height: 100,
                width: 120,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return SizedBox(
                      height: 100,
                      width: 120,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return const SizedBox(
                    height: 100,
                    width: 120,
                    child: Center(
                      child: Text('Failed!'),
                    ),
                  );
                },
              ),
              const SizedBox(width: 10,),
              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model.title.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    children: [
                      Image.asset("assets/calendar.png", height: 18, width: 18,),
                      const SizedBox(width: 8,),
                      Text(
                        widget.model.publishedAt.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 6,),
                  Row(
                    children: [
                      Image.asset("assets/info.png", height: 18, width: 18,),
                      const SizedBox(width: 8,),
                      Text(
                        widget.model.source!.name.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      )
                    ],
                  )
                ],
              ))
            ]
        ),
      ),
    );
  }
}
