import 'package:flutter/material.dart';
import 'package:loudweather/Models/weather_model.dart';

class Item extends StatelessWidget {
  WeeklyWeather? item;
  int? day;
  Item({required this.item, required this.day});
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidget = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: myHeight * 0.015, horizontal: myWidget * 0.07),
      child: Container(
        height: myHeight * 0.11,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item!.day.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 17.5),
                ),
                Text(
                  '$day January',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5), fontSize: 15),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  item!.mainTemp.toString().replaceAll('°C', ''),
                  style: const TextStyle(color: Colors.white, fontSize: 45),
                ),
                const Text(
                  '°C \n ',
                  style: TextStyle(color: Colors.white, fontSize: 17.5),
                ),
              ],
            ),
            Image.asset(
              item!.mainImg.toString(),
              height: myHeight * 0.06,
              width: myWidget * 0.16,
            )
          ],
        ),
      ),
    );
  }
}
