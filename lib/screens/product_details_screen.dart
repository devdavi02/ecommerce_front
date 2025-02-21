import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_front/controllers/product_controller.dart';
import 'package:ecommerce_front/controllers/cart_controller.dart';
import 'package:ecommerce_front/utils/app_storage.dart';
import 'package:ecommerce_front/widgets/question_dialog.dart';
import 'package:ecommerce_front/models/product.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({required this.product});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  List<Map<String, dynamic>> questions = []; // Lista para armazenar perguntas e respostas
  bool isLoading = true; // Indicador de carregamento

  @override
  void initState() {
    super.initState();
    _fetchQuestions(); // Busca as perguntas do backend ao carregar a tela
  }

  // Função para buscar as perguntas do backend
  Future<void> _fetchQuestions() async {
    final productController = Provider.of<ProductController>(context, listen: false);

    setState(() {
    isLoading = true; 
    questions = []; // Limpa a lista antes de buscar novas perguntas
  });

    try {
      await productController.loadQuestions(widget.product.id); // Carrega as perguntas do produto
      setState(() {
        questions = productController.questions; // Atualiza as perguntas do controller
        isLoading = false; // Carregamento concluído
      });
    } catch (e) {
      setState(() => isLoading = false); // Erro ao carregar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao carregar perguntas.")),
      );
    }
  }

  // Função para adicionar uma nova pergunta enviando ao backend
  Future<void> _addQuestion(String question) async {
    final productController = Provider.of<ProductController>(context, listen: false);

    try {
      await productController.sendQuestion(widget.product.id, question);
      _fetchQuestions(); // Atualiza a lista de perguntas
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro ao enviar pergunta.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product.name)), // Nome do produto no appbar
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double cardWidth = constraints.maxWidth > 600 ? 600 : constraints.maxWidth; // Define a largura do card
            return SingleChildScrollView(
              child: Container(
                width: cardWidth,
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Exibe a imagem do produto
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: Image.network(
                          "assets/images/user_avatar.webp",
                          width: double.infinity,
                          height: 400,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Nome do produto
                            Text(widget.product.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),

                            // Preço do produto
                            Text("R\$${widget.product.price.toStringAsFixed(2)}", style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold)),
                            SizedBox(height: 16),

                            // Subcategoria do produto
                            Text("Subcategoria: ${widget.product.subCategory.name}", style: TextStyle(fontSize: 16)),
                            SizedBox(height: 8),

                            // Formas de pagamento
                            Text("Formas de pagamento: Cartão, Boleto, Pix", style: TextStyle(fontSize: 16)),
                            SizedBox(height: 8),

                            // Avaliação média do produto
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber),
                                SizedBox(width: 4),
                                Text("${widget.product.average}", style: TextStyle(fontSize: 16)),
                              ],
                            ),

                            // Barra de avaliação interativa
                            Row(
                              children: [
                                RatingBar.builder(
                                  initialRating: widget.product.average,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                                  onRatingUpdate: (rating) {
                                    Provider.of<ProductController>(context, listen: false).sendRating(widget.product.id, rating.toInt());
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 16),

                            // Botão para adicionar ao carrinho
                            Center(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Provider.of<CartController>(context, listen: false).addProductToCart(AppStorage().getUserId(), widget.product.id, 1);
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Produto adicionado ao carrinho!")));
                                },
                                icon: Icon(Icons.shopping_cart),
                                label: Text("Adicionar ao Carrinho"),
                                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
                              ),
                            ),
                            SizedBox(height: 24),

                            // Seção de perguntas e respostas
                            Text("Perguntas e Respostas", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

                            // Indicador de carregamento ao buscar perguntas
                            if (isLoading)
                              Center(child: CircularProgressIndicator())
                            else if (questions.isEmpty)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Nenhuma pergunta feita ainda.", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
                              )
                            else
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: questions.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 12),

                                      // Exibe a pergunta
                                      Text("❓ ${questions[index]["question"]!}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                      SizedBox(height: 4),

                                      // Exibe a resposta (se houver)
                                      Text("💬 ${questions[index]["answer"] ?? "Aguardando resposta..."}", style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                                      Divider(),
                                    ],
                                  );
                                },
                              ),

                            // Botão para fazer uma nova pergunta
                            Center(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => QuestionDialog(onSubmit: _addQuestion), // Chama o diálogo de pergunta
                                  );
                                },
                                icon: Icon(Icons.question_answer),
                                label: Text("Fazer Pergunta"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
