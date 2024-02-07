import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/newsModel.dart';
import 'package:kaalan/services/apiservices.dart';
import 'package:kaalan/views/newReaderpage/newReaderPage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class NewHomeItem extends StatefulWidget {
  const NewHomeItem({super.key});

  @override
  State<NewHomeItem> createState() => _NewHomeItemState();
}

class _NewHomeItemState extends State<NewHomeItem> {
  List<NewsModel> news = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    List<NewsModel> fetchedNews = await fetchNews();

    try{
      setState(() {
      news = fetchedNews;
      news.shuffle();
      isLoading = false;
    });
    } catch(e){
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 10,
        right: kwidth(context, 0.07),
        left: kwidth(context, 0.07),
        child: isLoading || news.isEmpty
            ? Shimmer.fromColors(
                baseColor: const Color.fromARGB(255, 226, 224, 224),
                highlightColor: const Color.fromARGB(255, 250, 250, 250),
                enabled: true,
                child: Container(
                  width: kwidth(context, 0.9),
                  padding: const EdgeInsets.all(17),
                  child: Column(children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color(0xFFF7F9FD),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "",
                              style: TextStyle(
                                  fontFamily: "Nominee",
                                  color: ksecondaryTextColor),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                "",
                                style: TextStyle(
                                    color: ksecondaryColor,
                                    fontFamily: "Nominee",
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          ]),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        const SizedBox(
                          width: 17,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: kwidth(context, 0.45),
                                color: Colors.white,
                                child: Text(
                                  "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily: "Nominee",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: kwidth(context, 0.45),
                                height: 20,
                                color: Colors.white,
                              )
                            ]),
                      ]),
                    )
                  ]),
                ))
            : Container(
                width: kwidth(context, 0.9),
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color(0xFFF7F9FD),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${news[0].description}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: "Nominee",
                                color: ksecondaryTextColor),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.bottomToTop,
                                      child: NewReaderPage(
                                        newItem: news[0],
                                      )));
                            },
                            child: Text(
                              "Lire l'article",
                              style: TextStyle(
                                  color: ksecondaryColor,
                                  fontFamily: "Nominee",
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ]),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Row(children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(news[0].urlToImage)),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      const SizedBox(
                        width: 17,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: kwidth(context, 0.45),
                              child: Text(
                                news[0].title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontFamily: "Nominee",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RichText(
                                text: TextSpan(
                                    text: "",
                                    style: TextStyle(
                                        fontFamily: "Nominee",
                                        color: ksecondaryTextColor),
                                    children: <TextSpan>[
                                  TextSpan(
                                      text: "Actualité africaine",
                                      style: TextStyle(color: Colors.black)),
                                   
                                ]))
                          ]),
                    ]),
                  )
                ]),
              ));
  }
}
