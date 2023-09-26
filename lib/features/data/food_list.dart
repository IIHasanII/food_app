class FoodList {
  static const List<Map<String, dynamic>> foodItems = [
    {
      "name": "Pizza Margherita",
      "image_url":
          "https://www.foodandwine.com/thmb/7BpSJWDh1s-2M2ooRPHoy07apq4=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/mozzarella-pizza-margherita-FT-RECIPE0621-11fa41ceb1a5465d9036a23da87dd3d4.jpg",
      "description":
          "Pizza Margherita is a classic Italian pizza topped with tomato sauce, mozzarella cheese, fresh basil leaves, and a drizzle of olive oil. It's known for its simplicity and delicious flavors.",
      "category": "Dinner",
      "cuisine": "Italian",
    },
    {
      "name": "Hamburger",
      "image_url":
          "https://arc-anglerfish-washpost-prod-washpost.s3.amazonaws.com/public/M6HASPARCZHYNN4XTUYT7H6PTE.jpg",
      "description":
          "A hamburger is a popular fast-food item consisting of a ground meat patty (usually beef) placed inside a sliced bun. It is often served with various toppings like lettuce, tomatoes, onions, and condiments.",
      "category": "Lunch",
      "cuisine": "American",
    },
    {
      "name": "Sushi",
      "image_url":
          "https://img.taste.com.au/lNnNoTvU/taste/2010/01/sushi-187034-1.jpg",
      "description":
          "Sushi is a Japanese dish consisting of vinegared rice combined with various ingredients such as seafood, vegetables, and occasionally tropical fruits. It's often served with pickled ginger, wasabi, and soy sauce.",
      "category": "Dinner",
      "cuisine": "Japanese",
    },
    {
      "name": "Spaghetti Bolognese",
      "image_url":
          "https://www.ericlyons.co.uk/wp-content/uploads/2021/06/8K0A7866-2000x1333.jpg",
      "description":
          "Spaghetti Bolognese is a classic Italian pasta dish made with a meaty tomato sauce, usually containing ground beef or pork, served over a bed of cooked spaghetti. It's a hearty and flavorful meal.",
      "category": "Dinner",
      "cuisine": "Italian",
    },
    {
      "name": "Caesar Salad",
      "image_url":
          "https://food-images.files.bbci.co.uk/food/recipes/easy_caesar_salad_64317_16x9.jpg",
      "description":
          "Caesar Salad is a refreshing salad made with romaine lettuce, croutons, Parmesan cheese, and a Caesar dressing that typically includes anchovies, garlic, egg yolk, and olive oil. It's a popular appetizer or side dish.",
      "category": "Lunch",
      "cuisine": "International",
    }
  ];
}

class FoodModel {
  final String name;
  final String description;
  final String imageUrl;
  final String category;
  final String cuisine;

  FoodModel(
      {required this.name,
      required this.description,
      required this.imageUrl,
      required this.category,
      required this.cuisine});

  static fromJson(Map<String, dynamic> foodData) {}
}
