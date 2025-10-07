import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mallhub_flutter/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:mallhub_flutter/presentation/bloc/store_bloc/store_bloc.dart';
import 'package:mallhub_flutter/presentation/views/home_page.dart';

void main(List<String> args) async {
  await dotenv.load(fileName: '.env');

  runApp(MultiBlocProvider(providers: <BlocProvider>[
    BlocProvider<ProductBloc>(
        create: (context) => ProductBloc()..add(FetchProduct())),
    BlocProvider<StoreBloc>(create: (context) => StoreBloc()..add(FetchStore()))
  ], child: const MallHub()));
}

class MallHub extends StatelessWidget {
  const MallHub({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
