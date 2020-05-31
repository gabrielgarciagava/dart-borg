/*
 * MIT License
 *
 * Copyright (c) 2020 Alexei Sintotski
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 */

import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:pubspec_yaml/pubspec_yaml.dart';

import '../utils/lazy_data.dart';

// ignore_for_file: public_member_api_docs

@immutable
class DartPackage {
  DartPackage({
    @required this.path,
    String Function(String) readFileSync = _readFileSync,
  }) : _pubspecYaml = LazyData(populate: () => readFileSync(path).toPubspecYaml());

  final String path;
  PubspecYaml get pubspecYaml => _pubspecYaml.entry;

  bool get isFlutterPackage => pubspecYaml.dependencies.any((d) => d.package() == 'flutter');

  final LazyData<PubspecYaml> _pubspecYaml;
}

String _readFileSync(String filePath) => File(join(filePath, 'pubspec.yaml')).readAsStringSync();