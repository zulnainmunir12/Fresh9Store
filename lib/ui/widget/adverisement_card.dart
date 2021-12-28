import 'package:flutter/material.dart';
import 'package:fresh9_rider/ui/shared/app_colors.dart';

class AdvertisementCard extends StatelessWidget {
  Map data;
  AdvertisementCard(this.data);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        width: MediaQuery.of(context).size.shortestSide * 0.93,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AppColor.primaryColor),
        child: Stack(
          children: [
            ClipRRect(
              child: Image.network(
                data['imageUrl'],
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.shortestSide * 0.93,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            Positioned(
              child: Text(data['text'] == "" ? "" : data['text'],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              bottom: 10,
              left: 10,
            )
          ],
        ),
      ),
    );
  }
}
