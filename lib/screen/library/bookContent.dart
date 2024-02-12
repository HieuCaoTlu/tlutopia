// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:tlutopia/model/book.dart';
import 'package:tlutopia/screen/library/bookDetail.dart';

class BookContent extends StatefulWidget {
  final List<Book> collection;
  final String content;
  const BookContent(
    this.collection,
    this.content, {
    super.key,
  });

  @override
  State<BookContent> createState() => _BookContentState();
}

class _BookContentState extends State<BookContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Text(
            widget.content,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: widget.collection.length,
            separatorBuilder: (context, _) => const SizedBox(
              width: 20,
            ),
            itemBuilder: (context, index) =>
                buildCard(widget.collection[index]),
          ),
        ),
      ],
    );
  }

  Widget buildCard(Book item) => Container(
        width: 130,
        height: 300,
        color: const Color(0xffECECEC),
        child: Material(
          child: InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    DetailBook(item: item))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 3 / 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: NetworkImage(item.cover),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          maxLines: 1,
                          softWrap: false,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                        Text(
                          item.author,
                          maxLines: 1,
                          softWrap: false,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
