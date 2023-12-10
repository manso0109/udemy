import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/shop_app/categories/cat_cubit/cubit.dart';
import 'package:flutter_application_1/modules/shop_app/categories/cat_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/Components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCategoriesCubit, ShopCategoriesStates>(
      builder: (BuildContext context, ShopCategoriesStates state) {
        var productMap = ShopCategoriesCubit.get(context).productData;

        return SingleChildScrollView(
          child: Column(
            children: [
              CategoryBuilderWidget(
                  productMap, 0, context, ShopCategoriesCubit.get(context)),
            ],
          ),
        );
      },
      listener: (BuildContext context, ShopCategoriesStates state) {},
    );
  }
}
