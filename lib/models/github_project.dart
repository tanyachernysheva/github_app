import 'package:github_app/models/owner.dart';

final class GitHubProject {
  final String? title;
  final String? description;
  final Owner? owner;
  final String? htmlUrl;
  final List<String> topics;
  final String? updatedAt;
  final int? stargazersCount;
  final String? language;

  GitHubProject({
    this.title,
    this.description,
    this.owner,
    this.htmlUrl,
    this.topics = const [],
    this.updatedAt,
    this.stargazersCount,
    this.language,
  });

  factory GitHubProject.fromJson(Map<String, dynamic> json) {
    return GitHubProject(
      title: json['full_name'] as String?,
      description: json['description'] as String?,
      owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
      htmlUrl: json['html_url'] as String?,
      topics: [...((json['topics'] as List?) ?? []).map((e) => e.toString())],
      updatedAt: json['updated_at'] as String?,
      stargazersCount: json['stargazers_count'] as int?,
      language: json['language'] as String?,
    );
  }
}
