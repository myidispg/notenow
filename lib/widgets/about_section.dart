import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes_app/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Developed By".toUpperCase(),
            style: TextStyle(
                fontSize: 16,
                letterSpacing: 1.1,
                fontWeight: FontWeight.w500,
                color: kDarkThemeWhiteGrey),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            "Prashant Goyal",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 12,
          ),
          OutlinedButton.icon(
            onPressed: () async {
              await canLaunch("https://github.com/myidispg/")
                  ? await launch("https://github.com/myidispg/")
                  : throw "Could not launch https://github.com/myidispg/";
            },
            icon: Icon(Icons.link),
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                BorderSide(color: kDarkThemeWhiteGrey),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(
                    horizontal: deviceWidth * 0.1,
                    vertical: deviceHeight * 0.01),
              ),
            ),
            label: Text(
              "Github",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: kDarkThemeWhiteGrey,
                  letterSpacing: 1.05),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            "Made with".toUpperCase(),
            style: TextStyle(
                fontSize: 16,
                letterSpacing: 1.1,
                fontWeight: FontWeight.w500,
                color: kDarkThemeWhiteGrey),
          ),
          SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/flutter.svg',
                width: 30,
                height: 30,
              ),
              SizedBox(
                width: deviceWidth * 0.04,
              ),
              Text(
                'Flutter',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              )
            ],
          )
        ],
      ),
    );
  }
}
