part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<Product> hotProducts;
  final List<Product> allProducts;
  final bool isLoadingHotProducts;
  final bool isLoadingAllProducts;

  final bool hasReachedMax;
  final String? error;

  const HomeState({
    this.hotProducts = const [],
    this.allProducts = const [],
    this.isLoadingHotProducts = true,
    this.isLoadingAllProducts = true,
    this.hasReachedMax = false,
    this.error,
  });

  HomeState copyWith({
    List<Product>? hotProducts,
    List<Product>? allProducts,
    bool? isLoadingHotProducts,
    bool? isLoadingAllProducts,
    bool? isLoadingMore,
    bool? hasReachedMax,
    String? error,
  }) {
    return HomeState(
      hotProducts: hotProducts ?? this.hotProducts,
      allProducts: allProducts ?? this.allProducts,
      isLoadingHotProducts: isLoadingHotProducts ?? this.isLoadingHotProducts,
      isLoadingAllProducts: isLoadingAllProducts ?? this.isLoadingAllProducts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    hotProducts,
    allProducts,
    isLoadingHotProducts,
    isLoadingAllProducts,
    hasReachedMax,
    error,
  ];
}
