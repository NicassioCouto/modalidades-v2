// ignore_for_file: avoid_print
import 'package:aula/apis/servicos.dart';
import 'package:aula/estado.dart';
import 'package:flutter/material.dart';

class ModalidadeCard extends StatefulWidget {
  final dynamic produto;

  const ModalidadeCard(this.produto, {super.key});

  @override
  State<StatefulWidget> createState() {
    return ModalidadeCardState();
  }
}

class ModalidadeCardState extends State<ModalidadeCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 340,
        child: GestureDetector(
            onTap: () {
              estadoApp.mostrarDetalhes(widget.produto["produto_id"]);
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0)),
                      child: Image.network(
                          caminhoArquivo(widget.produto["imagem1"]))),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(children: [
                      Image.network(caminhoArquivo(widget.produto["avatar"]),
                          width: 34),
                      Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            widget.produto["nome_produto"],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ))
                    ]),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, top: 5, bottom: 10),
                    child: Text(
                      widget.produto["descricao"],
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "R\$ ${widget.produto["preco"].toString()}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.favorite_rounded,
                            color: Colors.red,
                            size: 18,
                          ),
                          Text(
                            widget.produto["curtidas"].toString(),
                          ),
                        ],
                      ),
                    )
                  ])
                ],
              ),
            )));
  }
}
