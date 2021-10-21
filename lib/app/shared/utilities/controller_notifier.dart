import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

class ControllerNotifier extends ChangeNotifier {
  final _loading = RxNotifier<bool>(false);
  final _loadList = RxNotifier<bool>(false);
  final _hasError = RxNotifier<bool>(false);

  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  bool get hasError => _hasError.value;
  set hasError(bool value) => _hasError.value = value;

  bool get loadList => _loadList.value;
  set loadList(bool value) => _loadList.value = value;
}
