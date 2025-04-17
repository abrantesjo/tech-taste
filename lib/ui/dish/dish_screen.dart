import 'package:flutter/material.dart';
import 'package:myapp/model/dish.dart';
import 'package:myapp/ui/_core/app_colors.dart';
import 'package:myapp/ui/_core/widgets/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:myapp/ui/_core/bag_provider.dart';

class DishDetailScreen extends StatefulWidget {
  final Dish dish;

  const DishDetailScreen({super.key, required this.dish});

  @override
  _DishDetailScreenState createState() => _DishDetailScreenState();
}

class _DishDetailScreenState extends State<DishDetailScreen> {
  int quantity = 1; // Quantidade inicial

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: widget.dish.name),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/dishes/default.png',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.dish.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainColor,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "R\$ ${widget.dish.price.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 19.5, color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.dish.description ?? "Descrição não disponível.",
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 24),

            // Contador com setas
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_downward),
                    onPressed: () {
                      if (quantity > 1) {
                        setState(() {
                          quantity--;
                        });
                      }
                    },
                    iconSize: 12,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '$quantity',
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
                SizedBox(width: 8),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor, // Cor de fundo
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_upward),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    iconSize: 12, // Tamanho do ícone
                    color: Colors.white, // Cor do ícone
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                // Adiciona o prato ao carrinho com a quantidade selecionada
                List<Dish> dishes = List.generate(
                  quantity,
                  (index) => widget.dish,
                );
                Provider.of<BagProvider>(
                  context,
                  listen: false,
                ).addAllDishes(dishes);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${widget.dish.name} foi adicionado ao carrinho!',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainColor,
              ),
              child: const Text("Adicionar ao carrinho"),
            ),
          ],
        ),
      ),
    );
  }
}
