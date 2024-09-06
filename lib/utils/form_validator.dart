import 'package:flutter/material.dart';

final class FormValidator{

  static String? nameValidator(String? s){

    if(s != null && s.isNotEmpty){
      if(s.containsNumbers()){
        return 'Don\'t combine numbers in name';
      }
      return null;
    }
    return 'Fill your Name';
  }

  static String? phoneValidator(String? s){

    if(s != null && s.isNotEmpty){

      if(s.containsCharacters()){
        return 'Phone shouldn\'t include letters';
      }

      return null;
    }
    return 'Fill your Phone';
  }

  static String? emailValidator(String? s){

    if(s != null && s.isNotEmpty){

      if(!s.contains('@')){
        return 'Not Valid Email, @ is Missed';
      }
      if(!s.contains('.')){
        return '.com is Missed!';
      }
      return null;
    }
    return 'Fill your Email';
  }

  static String? passwordValidator(String? s){

    if(s != null && s.isNotEmpty){

      if(s.length < 6)
      {
        return 'Short Password Length';
      }
      return null;
    }
    return 'Fill your Phone';
  }


}

extension StringExtension on String{

  /// Checks if the Numeric String containing Characters
  ///
  /// ex : (1425cc54) return true
  ///
  /// ex : (99265454) return false
  bool containsCharacters(){
    bool flag = false;

    for(var char in characters){
      if(double.tryParse(char) == null){
        flag = true;
      }
    }
    return flag;
  }
  /// Checks if the Letter Based String containing Numbers
  /// ex : (John50 Smith) return true
  /// ex : (John Smith) return false
  bool containsNumbers(){
    bool flag = false;

    for(var char in characters){
      if(double.tryParse(char) != null){
        flag = true;
      }
    }
    return flag;
  }


}

List<String> splitter(String str){

  String catchy = '';

  for(var char in str.characters){
    if(double.tryParse(char) == null){
      catchy = char;
    }
  }
  var list =  str.split(catchy);

  if(list[1].trim() == 'l'){
    list[0] = (double.parse(list[0].trim()) * 1000).toString();
    list[1] = 'ml';
    return list;
  }
  else if(list[1].trim() == 'kg'){
    list[0] = (double.parse(list[0].trim()) * 1000).toString();
    list[1] = 'g';
    return list;
  }
  return list;

}





