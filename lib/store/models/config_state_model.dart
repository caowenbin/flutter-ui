import 'package:efox_flutter/config/index.dart' as Config;
import 'package:efox_flutter/store/index.dart' show model;
import 'package:efox_flutter/utils/loadAsset.dart' show loadAssets;

class ConfigInfo {
  bool isPro = Config.isPro;
  String version = '1.0';
  dynamic env = Config.env;
}

ConfigInfo _appConfigInfo = new ConfigInfo();

class ConfigModel {
  get state => _appConfigInfo;

  dynamic getVersion () async {
    print('version ${model.config.state.env.versionUrl}');
    String _version = await loadAssets(model.config.state.env.versionUrl).then((res) {
      return res['version'] ?? '1.0';
    }).catchError((err) {
      return '1.0';
    });
    print('_version ${_version}');
    return _version;
  }

  methods(name, payload) async {
    print('payload= $payload');

    switch (name) {
      case 'setEnv':
        _appConfigInfo.isPro = !_appConfigInfo.isPro;
        break;
      case 'setVersion':
        _appConfigInfo.version = await this.getVersion();
        break;
    }
  }
}
