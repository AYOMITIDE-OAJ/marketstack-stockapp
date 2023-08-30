import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textHeading5(String text, Color color, {TextAlign? align}) {
  return Text(text,
      textAlign: align,
      style: GoogleFonts.notoSans(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          decoration: TextDecoration.none,
          color: color
      ));
}

Widget textSemiBold(String text, Color color, {TextAlign? align}) {
  return Text(text,
      textAlign: align,
      style: GoogleFonts.notoSans(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          decoration: TextDecoration.none,
          color: color
      ));
}

Widget textMiniTextRegular(String text, Color color, {TextAlign? align}) {
  return Text(text,
      textAlign: align,
      style: GoogleFonts.notoSans(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          decoration: TextDecoration.none,
          color: color
      ));
}

Widget textMiniMiniMedium(String text, Color color, {TextAlign? align}) {
  return Text(text,
      textAlign: align,
      style: GoogleFonts.notoSans(
          fontWeight: FontWeight.w500,
          fontSize: 10,
          decoration: TextDecoration.none,
          color: color
      ));
}

Widget textSmall(String text, Color color, {TextAlign? align}) {
  return Text(text,
      textAlign: align,
      style: GoogleFonts.notoSans(
          fontWeight: FontWeight.w400,
          fontSize: 10,
          decoration: TextDecoration.none,
          color: color
      ));
}