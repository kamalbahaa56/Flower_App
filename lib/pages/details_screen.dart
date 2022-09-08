// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import '../model/items.dart';
import '../shared/appbar.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
  static final String id = 'DetailsScreen';
  ModelPaltes modell ;
   Details({
    Key? key,
    required this.modell,
  }) : super(key: key);
  
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool IsShowMore = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Screen'),
        actions: [
         APPBAR(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('${widget.modell.image}'),
            SizedBox(
              height: 10,
            ),
            Text(
              '${widget.modell.Num}',
              style: TextStyle(fontSize: 20.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 129, 129),
                  ),
                  child: Text(
                    'new',
                    style: TextStyle(fontSize: 10.0),
                  ),
                ),
                // Stars ////..................................
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 25,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 25,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 25,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 25,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 25,
                    ),
                  ],
                ),
                Spacer(),

                /// Icon ++ Text .............................
                Row(
                  children: [
                    Icon(
                      Icons.edit_location,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('${widget.modell.location}'),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ],
            ),

            ///  ALL Detils...........................................
            SizedBox(
              height: 10,
            ),
            Container(
                width: double.infinity,
                child: Text(
                  'Details : ',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.start,
                ),
                ),

            SizedBox(
              height: 10,
            ),
            Text(
              'Basically, each flower consists of a floral axis upon which are borne the essential organs of reproduction (stamens and pistils) and usually accessory organs (sepals and petals); the latter may serve to both attract pollinating insects and protect the essential organs. The floral axis is a greatly modified stem; unlike vegetative stems, which bear leaves, it is usually contracted, so that the parts of the flower are crowded together on the stem tip, the receptacle. The flower parts are usually arrayed in whorls (or cycles) but may also be disposed spirally, especially if the axis is elongate. There are commonly four distinct whorls of flower parts: (1) an outer calyx consisting of sepals; within it lies (2) the corolla, consisting of petals; (3) the androecium, or group of stamens; and in the centre is (4) the gynoecium, consisting of the pistils.',
              maxLines: IsShowMore ? 5 : null,
              overflow: TextOverflow.fade,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  IsShowMore = !IsShowMore;
                });
              },
              child: Text(IsShowMore ? 'Show more' : 'Show Less'),
            ),
          ],
        ),
      ),
    );
  }
}
