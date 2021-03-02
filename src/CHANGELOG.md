# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## 1.2.2+5 - 2021-03-02
### Changed
- pdf화면에서 광고제거
- get: ^3.12.1 -> get: ^3.25.6

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
