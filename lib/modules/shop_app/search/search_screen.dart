// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/shop_app/categories/cat_cubit/cubit.dart';
import 'package:flutter_application_1/modules/shop_app/search/cubit/search_cubit.dart';
import 'package:flutter_application_1/modules/shop_app/search/cubit/search_states.dart';
import 'package:flutter_application_1/shared/Components/components.dart';
import 'package:flutter_application_1/shared/Components/constants.dart';
import 'package:flutter_application_1/shared/Cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var searchController = TextEditingController();

class SearchScreen2 extends StatelessWidget {
  const SearchScreen2({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, searchStates>(
        builder: (context, state) {
          List<String>? list = ShopCategoriesCubit.get(context).catList;
          List<int>? IntList = ShopCategoriesCubit.get(context).catIntList;
          var model2 = SearchCubit.get(context).catModel;

          return Scaffold(
            appBar: AppBar(title: Text('Search screen'), centerTitle: true),
            body: SingleChildScrollView(
              child: Column(children: [
                if (state is SearchLoadingState) LinearProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: defaultFormField(
                      controller: searchController,
                      inputType: TextInputType.text,
                      hintText: 'search',
                      labelText: 'search',
                      prefix: Icon(Icons.search),
                      // ignore: body_might_complete_normally_nullable
                      onchange: (String? title) {
                        SearchCubit.get(context).Search(
                            title: searchController.text,
                            priceMin: '0',
                            priceMax: '',
                            ID: '');
                      },
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'enter your search here';
                        }
                        return null;
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppCubit.get(context).isDark
                            ? Colors.white
                            : Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    height: 120,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 25,
                          decoration: BoxDecoration(
                              color: AppCubit.get(context).isDark
                                  ? Colors.black
                                  : Colors.white),
                          child: Center(
                            child: Text(
                              'Price',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.apply(
                                      color: AppCubit.get(context).isDark
                                          ? Colors.white
                                          : Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Min',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.apply(
                                      color: AppCubit.get(context).isDark
                                          ? Colors.black
                                          : Colors.white,
                                    )),
                            SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                color: AppCubit.get(context).isDark
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              width: 280,
                              height: 70,
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                    valueIndicatorColor: Colors.amber),
                                child: RangeSlider(
                                  labels: RangeLabels(
                                    '${SearchCubit.get(context).selectedRange.start} Min',
                                    '${SearchCubit.get(context).selectedRange.end} Max',
                                  ),
                                  onChanged: (RangeValues value) {
                                    SearchCubit.get(context).changeRange(value);
                                    print(value);
                                  },
                                  values:
                                      SearchCubit.get(context).selectedRange,
                                  divisions: 100,
                                  max: 10000,
                                  min: 0,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text('Max',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.apply(
                                      color: AppCubit.get(context).isDark
                                          ? Colors.black
                                          : Colors.white,
                                    )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppCubit.get(context).isDark
                          ? Colors.white
                          : Colors.black,
                      borderRadius: BorderRadius.circular(20)),
                  width: 380,
                  height: 70,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Category :',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppCubit.get(context).isDark
                                ? Colors.black
                                : Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: DropdownMenu<String>(
                          width: 210,
                          trailingIcon: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: AppCubit.get(context).isDark
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            child: Icon(
                              Icons.arrow_downward,
                              color: AppCubit.get(context).isDark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          initialSelection: SearchCubit.get(context).category,
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.apply(
                                  color: AppCubit.get(context).isDark
                                      ? Colors.black
                                      : Colors.white),
                          hintText: SearchCubit.get(context).category == null
                              ? 'Please Pick one'
                              : null,
                          onSelected: (value) {
                            SearchCubit.get(context).category = value;
                          },
                          dropdownMenuEntries: list!
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList(),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppCubit.get(context).isDark
                              ? Colors.black
                              : Colors.white,
                        ),
                        child: IconButton(
                            onPressed: () {
                              SearchCubit.get(context).Search(
                                title: titleController.text,
                                priceMin: SearchCubit.get(context)
                                    .selectedRange
                                    .start
                                    .round()
                                    .toString(),
                                priceMax: SearchCubit.get(context)
                                    .selectedRange
                                    .end
                                    .round()
                                    .toString(),
                                ID: SearchCubit.get(context).category != null
                                    ? IntList!
                                        .elementAt(list.indexOf(
                                            SearchCubit.get(context)
                                                .category
                                                .toString()))
                                        .toString()
                                    : '',
                              );
                            },
                            icon: Icon(
                              Icons.search_outlined,
                              color: AppCubit.get(context).isDark
                                  ? Colors.white
                                  : Colors.black,
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
                SearchproductWidget(model2, context, SearchCubit.get(context)),
              ]),
            ),
          );
        },
        listener: (BuildContext context, state) {
          List<String>? list = ShopCategoriesCubit.get(context).catList;
          List<int>? IntList = ShopCategoriesCubit.get(context).catIntList;
          if (state is ShopSuccessDeleteProductsDataState) {
            SearchCubit.get(context).Search(
                title: titleController.text,
                priceMin: SearchCubit.get(context)
                    .selectedRange
                    .start
                    .round()
                    .toString(),
                priceMax: SearchCubit.get(context)
                    .selectedRange
                    .end
                    .round()
                    .toString(),
                ID: SearchCubit.get(context).category != null
                    ? IntList!
                        .elementAt(list!.indexOf(
                            SearchCubit.get(context).category.toString()))
                        .toString()
                    : '');
          }
        },
      ),
    );
  }
}
