import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension BuildContextExtensions on BuildContext {
  T getArgumentByKey<T>(String key) {
    var args = ModalRoute.of(this)!.settings.arguments as Map<String, Object>;
    return args[key] as T;
  }

  T getArgument<T>() {
    return ModalRoute.of(this)!.settings.arguments as T;
  }

  T getProvided<T>(){
    return Provider.of<T>(this);
  }

  T getProvidedAndForget<T>(){
    return Provider.of<T>(this, listen: false);
  }
}
