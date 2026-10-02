import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stylish/core/widgets/app_bottom_nav.dart';
import 'package:stylish/core/widgets/cart_fab.dart';

import 'package:stylish/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:stylish/features/cart/presentation/view/cart_screen.dart';

import 'package:stylish/features/favorites/presentation/cubit/favorites_cubit.dart';

import 'package:stylish/features/home/presentation/view/home_screen.dart';

import 'package:stylish/features/orders/presentation/cubit/orders_cubit.dart';

import 'package:stylish/features/product/presentation/view/products_screen.dart';
import 'package:stylish/features/profile/presentation/view/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const _pages = [HomeScreen(), ProductsScreen(), ProfileScreen()];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FavouriteCubit()),
        BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (_) => OrderCubit()),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: IndexedStack(index: _index, children: _pages),

            floatingActionButton: _index == 2
                ? null
                : CartFab(
                    onTap: () {
                      final cartCubit = context.read<CartCubit>();

                      final orderCubit = context.read<OrderCubit>();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MultiBlocProvider(
                            providers: [
                              BlocProvider.value(value: cartCubit),
                              BlocProvider.value(value: orderCubit),
                            ],
                            child: const CartScreen(),
                          ),
                        ),
                      );
                    },
                  ),

            bottomNavigationBar: AppBottomNav(
              currentIndex: _index,
              onTap: (i) {
                setState(() {
                  _index = i;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
