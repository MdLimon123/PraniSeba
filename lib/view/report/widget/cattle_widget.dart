import 'package:flutter/material.dart';
import 'package:prani_sheba/services/NetworkServices.dart';

class CattleWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String tag;
  final String gender;

  CattleWidget({required this.imageUrl, required this.title, required this.tag, required this.gender});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 100,
              height: 85,
              margin: EdgeInsets.only(right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: imageUrl != null
                    ? Image.network(
                        '${NetworkServices.imageUrl + imageUrl}',
                        width: 100,
                        height: 85,
                        fit: BoxFit.fill,
                        colorBlendMode: BlendMode.color,
                      )
                    : Image.asset(
                        'assets/images/cow_icon.png',
                        width: 100,
                        height: 85,
                        fit: BoxFit.fill,
                        colorBlendMode: BlendMode.color,
                      ),
              ),
            ),
            Flexible(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 0),
                  child: Text(
                    'গরুর নাম: $title',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    'কানে লাগানো ট্যাগ: $tag',
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15, color: Colors.grey, fontStyle: FontStyle.normal),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    'লিঙ্গ: $gender',
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15, color: Colors.grey, fontStyle: FontStyle.normal),
                  ),
                ),
              ],
            ))
          ],
        ),
        Divider(
          color: Colors.grey,
        ),
      ],
    );
  }
}
