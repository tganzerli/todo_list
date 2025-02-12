import 'dart:typed_data';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list/core/services/client/rest_client_multipart.dart';

class MockFile extends Mock implements File {}

void main() {
  const fileKey = 'testFile';
  const fileName = 'example.txt';
  final fileBytes = Uint8List.fromList([1, 2, 3, 4]);

  setUpAll(() {
    registerFallbackValue(MockFile());
  });
  group('RestClientMultipart', () {
    test('should initialize with a valid file path', () {
      final tempFile = File('test_temp_file.txt');
      tempFile.writeAsBytesSync(fileBytes);

      final file = RestClientMultipart(fileKey: fileKey, path: tempFile.path);

      expect(file.fileKey, fileKey);
      expect(file.fileName, 'test_temp_file.txt');
      expect(file.path, tempFile.path);
      expect(file.fileBytes, isNotNull);
      expect(file.contentType, 'text/plain');

      tempFile.deleteSync();
    });

    test('should initialize with file bytes', () {
      final file = RestClientMultipart(
        fileKey: fileKey,
        fileName: fileName,
        fileBytes: fileBytes,
        contentType: 'text/plain',
      );

      expect(file.fileKey, fileKey);
      expect(file.fileName, fileName);
      expect(file.fileBytes, fileBytes);
      expect(file.contentType, 'text/plain');
    });

    test(
        'should throw assertion error if neither fileBytes nor path is provided',
        () {
      expect(
        () => RestClientMultipart(fileKey: fileKey),
        throwsA(isA<AssertionError>()),
      );
    });

    test('should infer content type based on file extension', () {
      final tempFile = File('document.pdf');
      tempFile.writeAsBytesSync(fileBytes);

      final file = RestClientMultipart(fileKey: fileKey, path: tempFile.path);
      expect(file.contentType, 'application/pdf');

      tempFile.deleteSync();
    });

    test('should default to application/octet-stream for unknown extensions',
        () {
      final tempFile = File('file.unknownext');
      tempFile.writeAsBytesSync(fileBytes);

      final file = RestClientMultipart(fileKey: fileKey, path: tempFile.path);
      expect(file.contentType, 'application/octet-stream');

      tempFile.deleteSync();
    });

    test('should convert to multipart form correctly', () {
      final file = RestClientMultipart(
        fileKey: fileKey,
        fileName: fileName,
        fileBytes: fileBytes,
        contentType: 'text/plain',
      );

      final multipartForm = file.toMultipartForm();

      expect(multipartForm, {
        'fileKey': fileKey,
        'fileName': fileName,
        'contentType': 'text/plain',
        'fileBytes': fileBytes,
      });
    });
  });
}
