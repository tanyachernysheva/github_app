import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:github_app/models/github_project.dart';
import 'package:github_app/repositories/github_projects_repository.dart';
import 'package:meta/meta.dart';

part 'github_projects_event.dart';
part 'github_projects_state.dart';

class GitHubProjectsBloc
    extends Bloc<GitHubProjectsEvent, GitHubProjectsState> {
  final ProjectsRepository repository;

  GitHubProjectsBloc(this.repository) : super(const GitHubProjectsInitial()) {
    on<GetGitHubProjectsEvent>(_getProjects);
  }

  Future<void> _getProjects(
    GetGitHubProjectsEvent event,
    Emitter<GitHubProjectsState> emit,
  ) async {
    try {
      emit(const GitHubProjectsState.loading());

      final String value = event.value ?? '';

      if (value.isEmpty) {
        emit(const GitHubProjectsState.initial());

        return;
      }

      final List<GitHubProject> projects = await repository.getProjects(value);

      if (projects.isNotEmpty) {
        emit(GitHubProjectsState.data(projects));
      } else {
        emit(const GitHubProjectsState.isEmpty());
      }
    } catch (e, stackTrace) {
      log('$e\n$stackTrace');

      emit(GitHubProjectsState.error(e.toString()));
    }
  }
}
