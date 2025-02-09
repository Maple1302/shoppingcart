import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoppingcart/services/product_service.dart';

import '../../../data/models/product.dart';


part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductService _productService;

  HomeBloc({ProductService? service}) : _productService = ProductService(), super(const HomeState()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadMoreProducts>(_onLoadMoreProducts);
  }

  Future<void> _onLoadProducts(LoadProducts event, Emitter<HomeState> emit) async {
    try {
      emit(const HomeState(
        isLoadingHotProducts: true,
        isLoadingAllProducts: true,
        error: null,
      ));

      final hotProducts = await _productService.getHotProducts();
      emit(state.copyWith(
        hotProducts: hotProducts,
        isLoadingHotProducts: false,
      ));

      final allProducts = await _productService.getProducts(page: 0);

      emit(state.copyWith(
        allProducts: allProducts,
        isLoadingAllProducts: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        isLoadingHotProducts: false,
        isLoadingAllProducts: false,
      ));
    }
  }

  Future<void> _onLoadMoreProducts(LoadMoreProducts event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(
        isLoadingAllProducts: true,
      ));
      final allProducts = await _productService.getProducts(page: event.page, pageSize: event.size);
      emit(state.copyWith(
        allProducts: [...state.allProducts, ...allProducts,],
        isLoadingAllProducts: false,
      ));
      if(allProducts.length < event.size) {
        emit(state.copyWith(
          hasReachedMax: true,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
      ));
    }
  }
}
