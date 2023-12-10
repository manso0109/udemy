// ignore_for_file: prefer_is_empty, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_application_1/layout/shop_app/cubit/states.dart';
import 'package:flutter_application_1/shared/Components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (BuildContext context, ShopStates state) {
        var productMap = ShopCubit.get(context).pagedData;
        return SingleChildScrollView(
          child: Column(
            children: [
              productMap?.data?.length == 0
                  ? noProductWidget(context, ShopCubit.get(context))
                  : builderWidget(productWidget(
                      productMap, context, ShopCubit.get(context))),
              pageSelectorBuilder(context, ShopCubit.get(context))
            ],
          ),
        );
      },
      listener: (BuildContext context, ShopStates state) {
        if (state is ShopErrorDeleteProductsDataState) {
          ShowToastComponant(context,
              msg: 'Something went wrong during delete',
              state: ToastStates.ERROR);
        }
        if (ShopCubit.get(context).pagedData == null &&
            ShopCubit.get(context).productData == null &&
            state is ShopSuccessDeleteProductsDataState) {
          ShowToastComponant(context,
              msg: 'Product delelted succesfully', state: ToastStates.SUCCESS);
          ShopCubit.get(context).GetproductDat2a();
          ShopCubit.get(context).page = inat;
          ShopCubit.get(context).offset =
              (ShopCubit.get(context).pageList![inat] - 1) * 10;
          ShopCubit.get(context).GetproductData();
          print(ShopCubit.get(context).page);
          print(ShopCubit.get(context).offset);
        }
      },
    );
  }
}
