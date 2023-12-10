import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/news_app/cubit/cubit/cubit.dart';
import 'package:flutter_application_1/layout/news_app/cubit/states/states.dart';
import 'package:flutter_application_1/shared/Components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var searchController = TextEditingController();

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocConsumer<newsCubit, newsState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var list = newsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Search'),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                    onSubmited: (String? value) {
                      return value;
                    },
                    controller: searchController,
                    inputType: TextInputType.text,
                    hintText: 'Search',
                    labelText: 'Search',
                    prefix: const Icon(Icons.search),
                    onchange: (String? value) {
                      newsCubit.get(context).getSearch(value);
                      return null;
                    },
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'search must not be empty';
                      }
                      return null;
                    }),
              ),
              Expanded(
                  child: articleBuilder(list, context, list.length,
                      isSearch: true))
            ],
          ),
        );
      },
    );
  }
}
