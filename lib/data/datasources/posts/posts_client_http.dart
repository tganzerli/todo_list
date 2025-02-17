import 'dart:developer';

import 'package:todo_list/core/core.dart';
import 'package:todo_list/data/constants/url_constants.dart';

class PostsClientHttp {
  final RestClient restClient;

  PostsClientHttp({required this.restClient});

  AsyncOutput<List<Map<String, dynamic>>> getPosts() async {
    try {
      final baseResponse = await restClient.request(RestClientRequest(
        baseUrl: UrlConstants.api.base,
        path: UrlConstants.api.posts,
        method: RestMethod.get,
      ));
      final data = baseResponse.data;
      if (data is! List<Map<String, dynamic>>) {
        return failure(
            FormatedException(message: 'Return with different formatting'));
      } else {
        return success(data);
      }
    } on BaseException catch (exception) {
      return failure(exception);
    } catch (e) {
      log(e.toString(), name: 'PostsClientHttp - getPosts');
      return failure(DefaultException(message: e.toString()));
    }
  }

  AsyncOutput<Map<String, dynamic>> addPosts(Map<String, dynamic> data) async {
    try {
      final baseResponse = await restClient.request(RestClientRequest(
        baseUrl: UrlConstants.api.base,
        path: UrlConstants.api.posts,
        method: RestMethod.post,
        data: data,
      ));
      final returnData = baseResponse.data;
      if (returnData is! Map<String, dynamic>) {
        return failure(
            FormatedException(message: 'Return with different formatting'));
      } else {
        return success(returnData);
      }
    } on BaseException catch (exception) {
      return failure(exception);
    } catch (e) {
      log(e.toString(), name: 'PostsClientHttp - addPosts');
      return failure(DefaultException(message: e.toString()));
    }
  }

  //Mock function
  AsyncOutput<Map<String, dynamic>> editPosts(Map<String, dynamic> data) async {
    try {
      return success(data);
    } on BaseException catch (exception) {
      return failure(exception);
    } catch (e) {
      log(e.toString(), name: 'PostsClientHttp - editPosts');
      return failure(DefaultException(message: e.toString()));
    }
  }
}
