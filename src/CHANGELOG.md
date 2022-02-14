# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## 1.4.1+8 - 2022-02-14 (릴리즈전...)
### Fixed
- Fatal Exception: java.lang.LinkageError 오류 수정
  https://github.com/googleads/googleads-mobile-flutter/issues/471#issuecomment-1038063215

## 1.4.0+7 - 2022-02-06
### Changed
- null-safety 적용
- advance_pdf_viewer: ^1.2.0 -> advance_pdf_viewer: ^2.0.1
- advance_pdf_viewer: ^2.0.1 android에서 crash 발생으로 인해 임시로 해당 문제를 수정한 repo참조(https://github.com/ncdm-stldr/pdf_viewer.git)
- path_provider: ^1.6.18 -> path_provider: ^2.0.8
- admob_flutter: ^0.3.4 -> google_mobile_ads: ^1.0.1
- get: ^4.1.4 -> get: ^4.6.1
- flushbar: ^1.10.4 -> another_flushbar: ^1.10.28
- package_info: ^0.4.1 -> package_info_plus: ^1.3.0
- vibration: ^1.4.0 -> vibration: ^1.7.4-nullsafety.0

### Added
- flutter_screenutil: ^5.1.1

## 1.3.0+6 - 2021-05-03
### Changed
- get: ^3.25.6 -> get: ^4.1.4
- 2021년 기준에 맞춰 수정

### Removed
- money_masted_text_controller.dart 삭제 (flutter_jk 참조하도록 변경)
- num_pad.dart 삭제 (flutter_jk에서 참조하도록 변경)

## 1.2.2+5 - 2021-03-02
### Changed
- pdf화면에서 광고제거
- get: ^3.12.1 -> get: ^3.25.6
- flutter_money_formatter --> money_formatter 로 교체

## 1.2.1 - 2020-11-16
### Changed
- 부양가족 및 자녀 수 유효범위 초과시 안내메시지 수정
- 빠른 숫자입력 flutter_jk.NumberButtonBar로 교체

### Removed
- int_stepper.dart 삭제(flutter_jk.NumStepper로 교체)
- income_tax_table.dart 삭제(flutter_jk참조 하도록 수정)

## 1.2.0 - 2020-10-01
### Added
- 근로소득간이세액표 pdf 보기 기능 추가

### Changed
- CompiledSdkVersion, targetSdkVersion 28에서 29로 변경
- firebase-analytics:17.2.2 에서 17.5.0 으로 변경
- KrUtils 클래스를 flutter_jk패키지로 이동
