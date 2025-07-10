

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pizza_ulk_practice/models/Recipe.dart';

class DataService {
  static const String _baseUrl = 'https://dummyjson.com/recipes';
  
  // Get all recipes with optional filtering
  Future<List<Recipe>> getRecipes([String? mealTypeFilter]) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl?limit=50'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final recipes = (data['recipes'] as List)
            .map((json) => Recipe.fromJson(json))
            .toList();

        // Apply meal type filter if provided
        if (mealTypeFilter != null && mealTypeFilter.isNotEmpty) {
          return recipes.where((recipe) => recipe.matchesMealType(mealTypeFilter)).toList();
        }

        return recipes;
      } else {
        throw Exception('Failed to load recipes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching recipes: $e');
    }
  }

  // Get a specific recipe by ID
  Future<Recipe> getRecipeById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Recipe.fromJson(data);
      } else {
        throw Exception('Failed to load recipe: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching recipe: $e');
    }
  }

  // Search recipes by name
  Future<List<Recipe>> searchRecipes(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/search?q=$query'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['recipes'] as List)
            .map((json) => Recipe.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to search recipes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching recipes: $e');
    }
  }

  // Get recipes by tag
  Future<List<Recipe>> getRecipesByTag(String tag) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/tag/$tag'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['recipes'] as List)
            .map((json) => Recipe.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load recipes by tag: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching recipes by tag: $e');
    }
  }

  // Get available meal types/tags for filtering
  Future<List<String>> getAvailableTags() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/tags'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<String>.from(data);
      } else {
        throw Exception('Failed to load tags: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching tags: $e');
    }
  }
}