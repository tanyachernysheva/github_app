import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_app/github_projects_bloc/github_projects_bloc.dart';
import 'package:github_app/models/github_project.dart';
import 'package:github_app/repositories/github_projects_repository.dart';
import 'package:github_app/widgets/project_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final GitHubProjectsBloc _bloc;

  @override
  void initState() {
    _bloc = GitHubProjectsBloc(ApiProjectsRepository());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            onChanged: (value) {
              EasyDebounce.debounce(
                'searchField',
                const Duration(milliseconds: 500),
                () {
                  _bloc.add(GitHubProjectsEvent.getProjects(value));
                },
              );
            },
            cursorColor: Colors.white,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: const InputDecoration(
              hintText: 'Search',
              icon: Icon(Icons.search),
              iconColor: Colors.white,
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.network(
                'https://www.cloudfoundry.org/wp-content/uploads/github-outline-1.png',
              ),
            ),
          ],
        ),
        body: BlocBuilder<GitHubProjectsBloc, GitHubProjectsState>(
          bloc: _bloc,
          builder: (context, state) {
            return switch (state) {
              GitHubProjectsInitial() => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.search,
                        size: MediaQuery.of(context).size.width / 2,
                      ),
                      const Text('Try to search any repositories'),
                    ],
                  ),
                ),
              GitHubProjectsDataisEmpty() => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.data_array,
                        size: MediaQuery.of(context).size.width / 2,
                      ),
                      const Text('Your search did not match any repositories'),
                    ],
                  ),
                ),
              GitHubProjectsData() => ListView.builder(
                  itemCount: state.projects.length,
                  itemBuilder: (context, index) {
                    final GitHubProject project = state.projects[index];

                    return ProjectCard(
                      project: project,
                    );
                  },
                ),
              GitHubProjectsLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              GitHubProjectsError() => Center(
                  child: Image.network(
                    'https://statics.twonav.com/images/wysiwyg/frontend/icon-404.png',
                  ),
                ),
            };
          },
        ),
      ),
    );
  }
}
