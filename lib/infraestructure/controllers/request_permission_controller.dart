import 'dart:async';
import 'package:permission_handler/permission_handler.dart';

class RequestPermissionController {
  final Permission _locactionPermission;
  RequestPermissionController(this._locactionPermission);

  final _streamController = StreamController<PermissionStatus>.broadcast();

  Stream<PermissionStatus> get onStatusChanged => _streamController.stream;

  request() async {
    final status = await _locactionPermission.request();
    _notify(status);
  }

  void _notify(PermissionStatus status) {
    if (!_streamController.isClosed && _streamController.hasListener) {
      _streamController.sink.add(status);
    }
  }

  void dispose() {
    _streamController.close();
  }
}