import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:rick_and_morty_wiki_app/theme/theme_app.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget
{
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ThemeApp.primaryColor,
      centerTitle: false,
      elevation: 0.0,
      title: SvgPicture.asset(
        'assets/images/logo_alfred.svg'
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
