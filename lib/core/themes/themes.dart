import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

sealed class CustomTheme {
  static final ThemeData lightTheme = ThemeData(
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w300,
        ),
        bodyMedium: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
        bodySmall: TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.w300,
        ),
        titleMedium:TextStyle (
        color: Colors.black,
        fontSize: 17,
        fontWeight: FontWeight.w300,
        ),
        titleSmall:TextStyle (
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.w300,
        ),
        titleLarge:TextStyle (
          color: Colors.black,
          fontSize: 19,
          fontWeight: FontWeight.w300,
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
        size: 19,
      ),

      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: MaterialStatePropertyAll(Colors.black),
          iconSize: MaterialStatePropertyAll(19),
        )
      ),
      inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: Colors.black,
        suffixIconColor: Colors.black,
        filled: true,
        fillColor: Colors.grey.shade200,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
        labelStyle: const TextStyle(fontFamily: 'TimesNewRoman', fontSize: 14),
        hintStyle: TextStyle(
          fontFamily: 'TimesNewRoman',
          fontSize: 13,
          fontWeight: FontWeight.w300,
        ),
        iconColor: Colors.black,
        hintFadeDuration: Duration(milliseconds: 100),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 1, color: Colors.blue.shade800),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 1, color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 1, color: Colors.red),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        )),
        minimumSize: MaterialStatePropertyAll(Size(double.infinity, 45)),
        backgroundColor: MaterialStatePropertyAll(Colors.green),
      )),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: CircleBorder(),
        elevation: 0,
        highlightElevation: 2,
        backgroundColor: Colors.white,
      ),
      dividerTheme: DividerThemeData(
        color: Colors.grey.shade300,
        thickness: .5,
        space: 0,
      ),
    tabBarTheme: TabBarTheme(
      indicatorColor: Colors.pink,
      labelStyle: TextStyle(
        color: Colors.pink,
        fontSize: 15,
      ),
      dividerHeight: 0,
      tabAlignment: TabAlignment.fill,
      unselectedLabelStyle: TextStyle(
        color: Colors.black,
        fontSize: 13,
      ),
      overlayColor: MaterialStatePropertyAll(Colors.grey),
      indicator: UnderlineTabIndicator(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Colors.pink,width: 2,),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
    ),
    scaffoldBackgroundColor: Colors.white,
    cardTheme: CardTheme(
      color: Colors.white,
      margin: EdgeInsets.zero,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      shadowColor: Colors.black,
      surfaceTintColor: Colors.white,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
       style: ButtonStyle(
         iconSize: MaterialStatePropertyAll(19),
         iconColor: MaterialStatePropertyAll(Colors.blue),
         surfaceTintColor: MaterialStatePropertyAll(Colors.white),
         overlayColor: MaterialStatePropertyAll(Colors.grey.shade300),
         backgroundColor: MaterialStatePropertyAll(Colors.white),
         minimumSize: MaterialStatePropertyAll(Size(double.infinity , 40)),
         side: MaterialStatePropertyAll(BorderSide(color: Colors.grey.shade300,width: 1)),
         textStyle: MaterialStatePropertyAll(TextStyle(
           fontWeight: FontWeight.w400,
           fontSize: 13,
         )),
         foregroundColor: MaterialStatePropertyAll(Colors.black)

       )
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      iconColor: Colors.blue,
      position: PopupMenuPosition.under,
      textStyle: TextStyle(
        fontWeight: FontWeight.w300,
      )
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colors.pink,
      linearMinHeight: 2,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      modalBackgroundColor: Colors.grey,
      constraints: BoxConstraints(minWidth: double.infinity),
    ),
    scrollbarTheme: ScrollbarThemeData(
      thickness: MaterialStatePropertyAll(3),
      thumbColor: MaterialStatePropertyAll(Colors.pink),
      radius: Radius.circular(3),
      thumbVisibility: MaterialStatePropertyAll(true),
      minThumbLength: 35,
    ),
    listTileTheme: ListTileThemeData(
      style: ListTileStyle.list,
      //contentPadding: EdgeInsets.all(8),
      iconColor: Colors.black,
      textColor: Colors.black,
      tileColor: Colors.white,
      subtitleTextStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: Colors.black87,
      ),
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
    ),
  );
}
