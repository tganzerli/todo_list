import 'dart:io';
import 'dart:typed_data';

import 'client.dart';

/// Represents a file to be sent as multipart form data in an HTTP request.
class RestClientMultipart implements RestClientHttpMessage {
  /// The key associated with the file in the multipart form.
  final String fileKey;

  /// The name of the file, extracted from the path if not explicitly provided.
  final String fileName;

  /// The file path on the local file system, if available.
  final String? path;

  /// The raw byte content of the file.
  final Uint8List? fileBytes;

  /// The MIME type of the file, automatically detected when possible.
  final String? contentType;

  /// Constructs a [RestClientMultipart] instance.
  ///
  /// - [fileKey] is required and represents the field name in the multipart request.
  /// - Either [fileBytes] or [path] must be provided. If a [path] is given,
  ///   the file will be read automatically.
  /// - If [fileName] is not provided, it will be extracted from [path] if available.
  /// - If [contentType] is not provided, it will be inferred from the file extension.
  ///
  /// Throws an assertion error if neither [fileBytes] nor a valid [path] is provided.
  RestClientMultipart({
    required this.fileKey,
    String? fileName,
    this.path,
    Uint8List? fileBytes,
    String? contentType,
  })  : assert(
          fileBytes != null || (path != null && File(path).existsSync()),
          'Either fileBytes or a valid file path must be provided.',
        ),
        fileBytes =
            fileBytes ?? (path != null ? File(path).readAsBytesSync() : null),
        fileName = fileName ??
            (path != null ? File(path).uri.pathSegments.last : 'unknown'),
        contentType = contentType ??
            (path != null ? _getMimeTypeFromExtension(path) : null);

  /// Converts the file details into a map for easier integration with HTTP multipart requests.
  Map<String, dynamic> toMultipartForm() {
    return {
      'fileKey': fileKey,
      'fileName': fileName,
      'contentType': contentType,
      'fileBytes': fileBytes,
    };
  }

  /// Returns a string representation of the multipart file for debugging purposes.
  @override
  String toString() {
    return 'RestClientMultipart { fileKey: $fileKey, fileName: $fileName, contentType: $contentType, fileBytes: ${fileBytes?.length} bytes }';
  }

  /// Determines the MIME type based on the file extension.
  static String? _getMimeTypeFromExtension(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();
    const mimeTypes = {
      'jpg': 'image/jpeg',
      'jpeg': 'image/jpeg',
      'png': 'image/png',
      'gif': 'image/gif',
      'bmp': 'image/bmp',
      'webp': 'image/webp',
      'svg': 'image/svg+xml',
      'pdf': 'application/pdf',
      'json': 'application/json',
      'xml': 'application/xml',
      'txt': 'text/plain',
      'csv': 'text/csv',
      'html': 'text/html',
      'htm': 'text/html',
      'css': 'text/css',
      'js': 'application/javascript',
      'mp3': 'audio/mpeg',
      'wav': 'audio/wav',
      'mp4': 'video/mp4',
      'avi': 'video/x-msvideo',
      'mov': 'video/quicktime',
      'zip': 'application/zip',
      'rar': 'application/x-rar-compressed',
      '7z': 'application/x-7z-compressed',
      'tar': 'application/x-tar',
      'gz': 'application/gzip',
      'doc': 'application/msword',
      'docx':
          'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'xls': 'application/vnd.ms-excel',
      'xlsx':
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'ppt': 'application/vnd.ms-powerpoint',
      'pptx':
          'application/vnd.openxmlformats-officedocument.presentationml.presentation',
    };

    return mimeTypes[extension] ?? 'application/octet-stream';
  }
}
