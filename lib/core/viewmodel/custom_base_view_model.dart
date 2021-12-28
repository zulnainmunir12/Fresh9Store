import 'package:flutter/widgets.dart';
import 'package:fresh9_rider/core/enums/enums.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/ui/shared/ui_helper.dart';

class CustomBaseViewModel extends ChangeNotifier {
  final NavigationService _navigationService = locator<NavigationService>();
  ViewState _state = ViewState.idle;
  bool _mounted = true;
  bool get mounted => _mounted;
  ViewState get state => _state;

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  String _serverError = UIHelper.noConnection;

  get serverError => _serverError;

  void setServerError(String value) {
    _serverError = value;
    notifyListeners();
  }

  void goBack() {
    _navigationService.goBack();
  }

  void goBackWithData(dynamic data) {
    _navigationService.goBackWithData(data);
  }
}
