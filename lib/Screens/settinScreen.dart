import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Screens/widgets/show_language_sheet_widget.dart';
import 'package:to_do/provider/my_provider.dart';

class SettingScreen extends StatelessWidget {
  static String routeName = 'setting';

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: myThemeData.lightColor,
      //   title: Text(AppLocalizations.of(context)!.todo,
      //       style: myThemeData.ligthTheme.textTheme.titleSmall),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.langauge,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.black54),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                ShowLanguegeDialoge(context);
              },
              child: Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Theme.of(context).primaryColor)),
                child: Text(
                  provider.languageCode == 'en' ? 'English' : 'عربي',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.black54),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              AppLocalizations.of(context)!.themeMode,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.black54),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Theme.of(context).primaryColor)),
              child: Text(
                AppLocalizations.of(context)!.light,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.black54),
              ),
            )
          ],
        ),
      ),
    );
  }

  void ShowLanguegeDialoge(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ShowLanguageSheetWidget();
      },
    );
  }
}
