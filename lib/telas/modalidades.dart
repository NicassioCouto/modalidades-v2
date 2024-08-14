// ignore_for_file: avoid_print, constant_identifier_names

import 'package:aula/apis/servicos.dart';
import 'package:flat_list/flat_list.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:aula/autenticador.dart';
import 'package:aula/autenticador_google.dart';
import 'package:aula/componentes/modalidadecard.dart';
import 'package:aula/estado.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Modalidades extends StatefulWidget {
  const Modalidades({super.key});

  @override
  State<StatefulWidget> createState() => ModalidadesState();
}

const TAMANHO_DA_PAGINA = 4;

class ModalidadesState extends State<Modalidades> {
  List<dynamic> _produtos = [];

  String _filtro = "";
  late TextEditingController _controladorFiltro;

  bool _carregando = false;
  int _ultimoProduto = 0;

  late ServicoProdutos _servicoProdutos;

  @override
  void initState() {
    _controladorFiltro = TextEditingController();
    _recuperarUsuarioLogado();

    _servicoProdutos = ServicoProdutos();
    _carregarProdutos();

    super.initState();
  }

  void _recuperarUsuarioLogado() {
    final usuario = FirebaseAuth.instance.currentUser;
    if (usuario != null) {
      final usuarioLogado = Usuario(usuario.displayName!, usuario.email!);

      Future.microtask(() {
        estadoApp.onLogin(usuarioLogado);
      });
    }
  }

  void _carregarProdutos() {
    setState(() {
      _carregando = true;
    });

    if (_filtro.isNotEmpty) {
      _servicoProdutos
          .findProdutos(_ultimoProduto, TAMANHO_DA_PAGINA, _filtro)
          .then((produtos) {
        setState(() {
          _carregando = false;
          _ultimoProduto = produtos.isNotEmpty
              ? produtos.last["produto_id"]
              : _ultimoProduto;

          _produtos.addAll(produtos);
        });
      });
    } else {
      _servicoProdutos
          .getProdutos(_ultimoProduto, TAMANHO_DA_PAGINA)
          .then((produtos) {
        setState(() {
          _carregando = false;
          _ultimoProduto = produtos.isNotEmpty
              ? produtos.last["produto_id"]
              : _ultimoProduto;

          _produtos.addAll(produtos);
        });
      });
    }
  }

  Future<void> _atualizarProdutos() async {
    _produtos = [];
    _ultimoProduto = 0;

    _carregarProdutos();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const SizedBox.shrink(),
          actions: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                  controller: _controladorFiltro,
                  // usar onChanged quando a filtragem jah ocorrer enquanto o
                  // usuario digitas
                  // onChanged: (texto) {
                  //   _filtro = texto;
                  // },
                  // usar onSubmitted quando a filtragem tiver que ocorrer
                  // depois do usuario digitar e confirmar
                  onSubmitted: (texto) {
                    _filtro = texto;

                    _atualizarProdutos();
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.search))),
            )),
            Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: estadoApp.temUsuarioLogado()
                    ? GestureDetector(
                        onTap: () {
                          AutenticadorGoogle().logout();
                          setState(() {
                            estadoApp.onLogout();
                          });

                          Toast.show("Você não está mais conectado",
                              duration: Toast.lengthLong,
                              gravity: Toast.bottom);
                        },
                        child: const Icon(Icons.logout, size: 30))
                    : GestureDetector(
                        onTap: () async {
                          await AutenticadorGoogle().login();

                          String nome =
                              FirebaseAuth.instance.currentUser!.displayName!;
                          String email =
                              FirebaseAuth.instance.currentUser!.email!;

                          Usuario usuario = Usuario(nome, email);

                          setState(() {
                            estadoApp.onLogin(usuario);
                          });

                          Toast.show("Você foi conectado com sucesso",
                              duration: Toast.lengthLong,
                              gravity: Toast.bottom);
                        },
                        child: const Icon(Icons.person, size: 30)))
          ],
        ),
        body: SizedBox(
          height: 1000,
          child: FlatList(
            data: _produtos,
            loading: _carregando,
            numColumns: 2,
            onRefresh: () {
              _filtro = "";
              _controladorFiltro.clear();

              return _atualizarProdutos();
            },
            onEndReached: () {
              _carregarProdutos();
            },
            onEndReachedDelta: 100,
            buildItem: (item, int index) {
              return SizedBox(height: 400, child: ModalidadeCard(item));
            },
            // listEmptyWidget: Container(
            //     alignment: Alignment.center,
            //     child: const Text("Não existem produtos para exibir :(")),
          ),
        ));
  }
}
