import 'package:github_app/http_client/http_client.dart';
import 'package:github_app/models/github_project.dart';
import 'package:github_app/models/owner.dart';
import 'package:github_app/routes.dart';

abstract interface class ProjectsRepository {
  Future<List<GitHubProject>> getProjects(String value);
}

final class FakeProjectsRepository implements ProjectsRepository {
  @override
  Future<List<GitHubProject>> getProjects(String value) async {
    await Future.delayed(const Duration(seconds: 1));

    final List<GitHubProject> repository = [
      GitHubProject(
        title: 'dart',
        description: 'subtitle',
        owner: Owner(
          id: 1,
          avatarUrl: '',
          login: 'login',
        ),
      )
    ];

    return repository;
  }
}

final class ApiProjectsRepository implements ProjectsRepository {
  final HttpClient httpClient;

  factory ApiProjectsRepository() {
    final HttpClient httpClient = HttpClient();

    return ApiProjectsRepository._(httpClient);
  }

  ApiProjectsRepository._(this.httpClient);

  @override
  Future<List<GitHubProject>> getProjects(String value) async {
    final List<GitHubProject> projects = [];

    final query = {
      'q': value,
    };

    final json = await httpClient.get(url: Api.repositories, query: query);
    final fetchedProjects = json['items'] as List;

    for (final el in fetchedProjects) {
      projects.add(GitHubProject.fromJson(el as Map<String, dynamic>));
    }

    return projects;
  }
}
