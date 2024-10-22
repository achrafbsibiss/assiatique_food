import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/receipe.dart';
import 'recipe_detail_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class RecipeGridScreen extends StatefulWidget {
  @override
  _RecipeGridScreenState createState() => _RecipeGridScreenState();
}

class _RecipeGridScreenState extends State<RecipeGridScreen> {
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
    await Future.delayed(Duration(milliseconds: 200)); // Simulating network delay
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
              title: Text('Assiatique Gallery',
                  style: TextStyle(shadows: [Shadow(color: Colors.black, blurRadius: 2)])),
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
              : SliverPadding(
                  padding: EdgeInsets.all(16),
                  sliver: AnimationLimiter(
                    child: SliverToBoxAdapter(
                      child: StaggeredGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        children: _recipes.map((recipe) {
                          int index = _recipes.indexOf(recipe);
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            columnCount: 2,
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: StaggeredGridTile.count(
                                  crossAxisCellCount: 2,
                                  mainAxisCellCount: index.isEven ? 2 : 1,
                                  child: _buildRecipeCard(recipe),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildRecipeCard(Recipe recipe) {
    return GestureDetector(
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
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                    ),
                  ),
                  child: Text(
                    recipe.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
