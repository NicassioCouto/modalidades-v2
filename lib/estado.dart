// ignore_for_file: unnecessary_getters_setters
import 'package:flutter/material.dart';

import 'autenticador.dart';

enum Situacao { mostrandoModalidades, mostrandoDetalhes }

class EstadoApp extends ChangeNotifier {
  Situacao _situacao = Situacao.mostrandoModalidades;
  Situacao get situacao => _situacao;
  set situacao(Situacao situacao) {
    _situacao = situacao;
  }

  int _idProduto = 0;
  int get idProduto => _idProduto;
  set idProduto(int idProduto) {
    _idProduto = idProduto;
  }

  Usuario? _usuario;
  Usuario? get usuario => _usuario;
  set usuario(Usuario? usuario) {
    _usuario = usuario;
  }

  void mostrarProdutos() {
    situacao = Situacao.mostrandoModalidades;

    notifyListeners();
  }

  void mostrarDetalhes(int idProduto) {
    situacao = Situacao.mostrandoDetalhes;
    this.idProduto = idProduto;

    notifyListeners();
  }

  void onLogin(Usuario usuario) {
    _usuario = usuario;

    notifyListeners();
  }

  void onLogout() {
    _usuario = null;

    notifyListeners();
  }

  bool temUsuarioLogado() {
    return _usuario != null;
  }
}

late EstadoApp estadoApp;
