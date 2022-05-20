class ProductModel {
  int? id;
  String? brand;
  String? name;
  String? price;
  String? priceSign;
  String? currency;
  String? imageLink;
  String? description;
  String? category;
  String? productType;
  String? apiFeaturedImage;

  ProductModel({
    this.id,
    this.brand,
    this.name,
    this.price,
    this.priceSign,
    this.currency,
    this.imageLink,
    this.description,
    this.category,
    this.productType,
    this.apiFeaturedImage,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['brand'];
    name = json['name'];
    price = json['price'];
    priceSign = json['price_sign'];
    currency = json['currency'];
    imageLink = json['image_link'];
    description = json['description'];
    category = json['category'];
    productType = json['product_type'];
    apiFeaturedImage = json['api_featured_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand'] = this.brand;
    data['name'] = this.name;
    data['price'] = this.price;
    data['price_sign'] = this.priceSign;
    data['currency'] = this.currency;
    data['image_link'] = this.imageLink;
    data['description'] = this.description;
    data['category'] = this.category;
    data['product_type'] = this.productType;
    data['api_featured_image'] = this.apiFeaturedImage;
    return data;
  }
}
