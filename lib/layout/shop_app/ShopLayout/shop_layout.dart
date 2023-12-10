import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_application_1/layout/shop_app/cubit/states.dart';
import 'package:flutter_application_1/modules/shop_app/categories/cat_cubit/cubit.dart';
import 'package:flutter_application_1/modules/shop_app/categories/cat_cubit/states.dart';
import 'package:flutter_application_1/modules/shop_app/search/search_screen.dart';
import 'package:flutter_application_1/shared/Components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);

    return StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          return snapshot.data == ConnectivityResult.none ||
                  snapshot.data == null
              ? Scaffold(
                  body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'No internet connection, Please Check your connection and try again.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        )
                      ]),
                )
              : BlocConsumer<ShopCubit, ShopStates>(
                  listener: (BuildContext context, Object? state) {},
                  builder: (BuildContext context, state) {
                    return BlocConsumer<ShopCategoriesCubit,
                        ShopCategoriesStates>(
                      listener:
                          (BuildContext context, ShopCategoriesStates state) {},
                      builder: (BuildContext context, state) => Scaffold(
                        appBar: AppBar(
                          title: const Text('Salla'),
                          actions: [
                            IconButton(
                                onPressed: () {
                                  NavigateTo(context, const SearchScreen2());
                                },
                                icon: const Icon(Icons.search)),
                          ],
                        ),
                        body: cubit.bottomScreens[cubit.currentIndex],
                        bottomNavigationBar: BottomNavigationBar(
                            onTap: (index) {
                              pagesController.scrollToIndex(inat,
                                  preferPosition: AutoScrollPosition.middle);
                              cubit.ChangeBottom(index);
                            },
                            currentIndex: cubit.currentIndex,
                            items: const [
                              BottomNavigationBarItem(
                                icon: Icon(Icons.home),
                                label: 'Home',
                              ),
                              BottomNavigationBarItem(
                                  icon: Icon(Icons.price_check),
                                  label: 'Products'),
                              BottomNavigationBarItem(
                                  icon: Icon(Icons.grid_view_sharp),
                                  label: 'Categeories'),
                              BottomNavigationBarItem(
                                  icon: Icon(Icons.settings),
                                  label: 'Settings'),
                            ]),
                      ),
                    );
                  });
        });
  }
}
