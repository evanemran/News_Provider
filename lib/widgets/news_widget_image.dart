import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_provider/models/news_model.dart';

class NewsWidgetImage extends StatefulWidget {
  const NewsWidgetImage({super.key, required this.model});

  final NewsModel model;

  @override
  State<NewsWidgetImage> createState() => _NewsWidgetImageState();
}

class _NewsWidgetImageState extends State<NewsWidgetImage> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(8,4,8,4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
            children: [
              Image.network(
                widget.model.urlToImage.toString(),
                height: size,
                width: size,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return SizedBox(
                      height: size,
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
                    height: size,
                    width: size,
                    child: const Center(
                      child: Text('Failed!'),
                    ),
                  );
                },
              ),
              Positioned(bottom: 0, child: Container(
                padding: const EdgeInsets.all(10),
                color: Colors.black45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 8,),
                    Text(
                      widget.model.title.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Image.asset("assets/calendar.png", height: 18, width: 18, color: Colors.white,),
                        const SizedBox(width: 8,),
                        Text(
                          widget.model.publishedAt.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Image.asset("assets/user.png", height: 18, width: 18, color: Colors.white,),
                        const SizedBox(width: 8,),
                        Text(
                          widget.model.author.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Image.asset("assets/info.png", height: 18, width: 18, color: Colors.white,),
                        const SizedBox(width: 8,),
                        Text(
                          widget.model.source!.name.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ))
            ]
        ),
      ),
    );
  }
}
