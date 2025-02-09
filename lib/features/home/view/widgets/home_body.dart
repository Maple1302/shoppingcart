import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/config/utils/screen_helper.dart';
import 'package:shoppingcart/features/home/bloc/home_bloc.dart';
import 'package:shoppingcart/features/home/view/widgets/product_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../data/models/product.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeBodyState();
}

class HomeBodyState extends State<HomeBody> {
  final ScrollController scrollController = ScrollController();
  static const _pageSize = 10;
  int page = 10;

  bool get isBottom {
    if (!scrollController.hasClients) return false;
    final max = scrollController.position.maxScrollExtent;
    final current = scrollController.position.pixels;
    return current >= max * 0.9;
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(
      () {
        if (isBottom && !context.read<HomeBloc>().state.hasReachedMax && !context.read<HomeBloc>().state.isLoadingAllProducts) {
          context.read<HomeBloc>().add(LoadMoreProducts(page: page, size: _pageSize));
          page += _pageSize;
        }
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> onRefresh() async {
    page = 0;
    context.read<HomeBloc>().add(const LoadProducts());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: onRefresh,
          child: Padding(
            padding: EdgeInsets.only(
              left: ScreenHelper.screenPadding(context),
            ),
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Text(
                      'Hot Products 🔥',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffef720b),
                      ),
                    ),
                  ),
                ),

                _buildHotProductsList(context),

                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Text(
                      'All Products',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffef720b),
                      ),
                    ),
                  ),
                ),

                _buildAllProductsGrid(context, state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHotProductsList(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    final itemWidth = ScreenHelper.listItemWidth(context);
    final fakeList = List.generate(
      getCrossAxisCount(context) + 1,
      (index) => const Product(
        image: 'assets/images/product_0.jpg',
      ),
    );
    final products =
        bloc.state.isLoadingHotProducts ? fakeList : bloc.state.hotProducts;

    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: itemWidth * 1.5 - 28,
          child: Skeletonizer(
            enabled: bloc.state.isLoadingHotProducts,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              addAutomaticKeepAlives: true,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return SizedBox(
                  width: itemWidth,
                  height: itemWidth * 1.5 - 30,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 16,
                      bottom: 3
                    ),
                    child: ProductCard(
                      product: product,
                      isHot: bloc.state.isLoadingHotProducts ? false : true,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAllProductsGrid(BuildContext context, HomeState state) {
    return SliverPadding(
      padding: EdgeInsets.only(
        right: ScreenHelper.screenPadding(context),
      ),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: getCrossAxisCount(context),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 0.75,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index >= state.allProducts.length) {
              return const Skeletonizer(
                enabled: true,
                child: ProductCard(
                  product: Product(
                    image: 'assets/images/product_0.jpg',
                  ),
                ),
              );
            }
            final product = state.allProducts[index];
            return ProductCard(
              product: product,
            );
          },
          childCount: state.hasReachedMax
              ? state.allProducts.length
              : state.allProducts.length + getCrossAxisCount(context),
        ),
      ),
    );
  }

  int getCrossAxisCount(BuildContext context) {
    if (ScreenHelper.isPhone(context)) {
      return 2;
    } else {
      return 4;
    }
  }
}
