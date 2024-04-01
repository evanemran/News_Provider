import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_provider/models/news_model.dart';

class NewsWidgetVertical extends StatefulWidget {
  const NewsWidgetVertical({super.key, required this.model});

  final NewsModel model;

  @override
  State<NewsWidgetVertical> createState() => _NewsWidgetVerticalState();
}

class _NewsWidgetVerticalState extends State<NewsWidgetVertical> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(8,4,8,4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
              const SizedBox(height: 10,),
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
              const SizedBox(height: 10,),
              Image.network(
                widget.model.urlToImage.toString(),
                height: size/2,
                width: size,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return SizedBox(
                      height: size/2,
                      width: size,
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
                  return SizedBox(
                    height: size/2,
                    width: size,
                    child: const Center(
                      child: Text('Failed!'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 8,),
                  Row(
                    children: [
                      Image.asset("assets/user.png", height: 18, width: 18,),
                      const SizedBox(width: 8,),
                      Text(
                        widget.model.author.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 6,),
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
              )
            ]
        ),
      ),
    );
  }
}
