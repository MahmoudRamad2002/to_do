import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/provider/my_provider.dart';
import 'package:to_do/shared/style/app_color.dart';

class ShowLanguageSheetWidget extends StatelessWidget {
  const ShowLanguageSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                provider.changeLangauge("en");
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Text('English',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: provider.languageCode == "en"
                              ? appColor.lightColor
                              : Colors.black54)),
                  const Spacer(),
                  Icon(Icons.done,
                      color: provider.languageCode == "en"
                          ? appColor.lightColor
                          : Colors.black54),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            thickness: 3,
            indent: 34,
            endIndent: 34,
            color: appColor.lightColor,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                provider.changeLangauge("ar");
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Text(
                    'Arbic',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: provider.languageCode != "en"
                            ? appColor.lightColor
                            : Colors.black54),
                  ),
                  const Spacer(),
                  Icon(Icons.done,
                      color: provider.languageCode != "en"
                          ? appColor.lightColor
                          : Colors.black54)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
