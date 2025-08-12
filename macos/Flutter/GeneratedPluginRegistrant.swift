//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import flutter_inappwebview_macos
import path_provider_foundation
// <<<<<<< ritesh
import shared_preferences_foundation
// =======
import share_plus
import sqflite_darwin
import url_launcher_macos
// >>>>>>> main

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  InAppWebViewFlutterPlugin.register(with: registry.registrar(forPlugin: "InAppWebViewFlutterPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
// <<<<<<< ritesh
//   SharedPreferencesPlugin.register(with: registry.registrar(forPlugin: "SharedPreferencesPlugin"))
// =======
  SharePlusMacosPlugin.register(with: registry.registrar(forPlugin: "SharePlusMacosPlugin"))
  SqflitePlugin.register(with: registry.registrar(forPlugin: "SqflitePlugin"))
  UrlLauncherPlugin.register(with: registry.registrar(forPlugin: "UrlLauncherPlugin"))
// >>>>>>> main
}
