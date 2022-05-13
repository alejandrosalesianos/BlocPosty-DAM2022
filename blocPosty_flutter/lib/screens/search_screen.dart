import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_posty/Bloc/bloc_bloc/bloc_bloc.dart';
import 'package:flutter_bloc_posty/model/bloc_model/all_blocs_response.dart';
import 'package:flutter_bloc_posty/repository/bloc/bloc_repository.dart';
import 'package:flutter_bloc_posty/repository/bloc/bloc_repository_impl.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  late BlocRepository blocRepository;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    blocRepository = BlocRepositoryImpl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 20, top: 60),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 50,
          height: 50,
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                labelText: 'Busca Blocs aqui'),
          ),
        ),
      ),
      BlocProvider(
        create: (context) {
          return BlocBloc(blocRepository)..add(FetchBlocEvent());
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 170,
          child: _createBlocsUser(context),
        ),
      ),
    ])));
  }

  _createBlocsUser(BuildContext context) {
    return BlocBuilder<BlocBloc, BlocState>(builder: (context, state) {
      if (state is BlocInitial) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is BlocFetched) {
        return _buildBlocsUser(context, state.blocs);
      } else {
        return const Text('No soportado');
      }
    });
  }

  _buildBlocsUser(BuildContext context, List<BlocModel> blocs) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StaggeredGridView.countBuilder(
          staggeredTileBuilder: (int index) =>
              index % 7 == 0 ? StaggeredTile.count(2, 2) : StaggeredTile.fit(1),
          crossAxisCount: 4,
          crossAxisSpacing: 4,
          mainAxisSpacing: 3,
          itemCount: blocs.length,
          itemBuilder: (context, index) {
            return Container(
                margin: const EdgeInsets.only(right: 10, bottom: 10),
                decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                width: 80,
                height: 100,
                child: buildBlocContent(blocs.elementAt(index), index));
          },
        ));
  }

  buildBlocContent(BlocModel blocModel, int index) {
    if (index % 7 == 0 && blocModel.multimedia.isNotEmpty) {
      return Column(
        children: [
          getImgBloc(context, blocModel, index),
          Text(
            '${blocModel.titulo}',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              '${blocModel.contenido}',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
        ],
      );
    }
    if (index % 7 == 0) {
      return Column(
        children: [
          getImgBloc(context, blocModel, index),
          Text(
            '${blocModel.titulo}',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              '${blocModel.contenido}',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 8,
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          getImgBloc(context, blocModel, index),
          Text(
            '${blocModel.titulo}',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              '${blocModel.contenido}',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
        ],
      );
    }
  }

  getImgBloc(BuildContext context, BlocModel bloc, int index) {
    if (bloc.multimedia.isEmpty) {
      return Text('');
    } else if (index % 7 == 0) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Image.network('${bloc.multimedia}'),
      );
    } else {
      return Text('');
    }
  }
}
