enum PostsStatusEnum {
  todo('to_do', 'Pendênte'),
  inProgress('in_progress', 'Em Andamento'),
  complete('complete', 'Completo'),
  ;

  final String value;

  final String description;

  const PostsStatusEnum(this.value, this.description);

  String toMap() => value;

  factory PostsStatusEnum.fromMap(String value) =>
      PostsStatusEnum.fromValue(value);

  factory PostsStatusEnum.fromValue(String value) {
    return switch (value) {
      'to_do' => PostsStatusEnum.todo,
      'in_progress' => PostsStatusEnum.inProgress,
      'complete' => PostsStatusEnum.complete,
      _ => throw Exception('Invalid enum value'),
    };
  }
  factory PostsStatusEnum.fromDescription(String description) {
    return switch (description) {
      'Pendênte' => PostsStatusEnum.todo,
      'Em Andamento' => PostsStatusEnum.inProgress,
      'Completo' => PostsStatusEnum.complete,
      _ => throw Exception('Invalid enum description'),
    };
  }
}
