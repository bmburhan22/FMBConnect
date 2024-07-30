import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal.shade900),
    useMaterial3: true,
    textTheme: GoogleFonts.poppinsTextTheme(),
    pageTransitionsTheme:const PageTransitionsTheme(builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder(),}),

    );
