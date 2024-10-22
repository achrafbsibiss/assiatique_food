import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/receipe.dart';
import 'recipe_detail_screen.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class RecipeListScreen extends StatefulWidget {
  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  List<Recipe> _recipes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    setState(() => _isLoading = true);
    final String response = await rootBundle.loadString('assets/recipes.json');
    await Future.delayed(
        Duration(milliseconds: 200)); // Simulating network delay
    final data = await json.decode(response);
    setState(() {
      _recipes = data.map<Recipe>((json) => Recipe.fromJson(json)).toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Assiatique Delights',
                  style: TextStyle(
                      shadows: [Shadow(color: Colors.black, blurRadius: 2)])),
              background: Image.asset(
                'assets/images/country_cuisine.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          _isLoading
              ? SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              : AnimationLimiter(
                  child: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: _buildRecipeCard(_recipes[index]),
                            ),
                          ),
                        );
                      },
                      childCount: _recipes.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildRecipeCard(Recipe recipe) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailScreen(recipe: recipe),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Hero(
                  tag: 'recipeImage${recipe.title}',
                  child: Image.asset(
                    recipe.image,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.transparent
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          recipe.subtitle,
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.timer, size: 16, color: Colors.white70),
                            SizedBox(width: 4),
                            Text(recipe.time,
                                style: TextStyle(color: Colors.white70)),
                            SizedBox(width: 16),
                            Icon(Icons.star, size: 16, color: Colors.amber),
                            SizedBox(width: 4),
                            Text(recipe.rating.toString(),
                                style: TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
