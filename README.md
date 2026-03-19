# nirsit_plugin

A new Flutter plugin project.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/to/develop-plugins),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

```
# Nirsit sdk ffi-bindings generate
  dart run ffigen

# 빌드 캐시 정리
flutter pub run build_runner clean

# 충돌하는 파일들을 삭제하고 재빌드
flutter pub run build_runner build --delete-conflicting-outputs
```