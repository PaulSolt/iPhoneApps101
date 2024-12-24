//
//  ContentView.swift
//  ComplexJSONLevelsDemo
//
//  Created by Paul Solt on 12/18/24.
//

//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}

import SwiftUI

// MARK: - Codable Structs

struct Root: Decodable {
    let eCommercePlatform: ECommercePlatform

    enum CodingKeys: String, CodingKey {
        case eCommercePlatform = "e_commerce_platform"
    }
}

struct ECommercePlatform: Decodable {
    let categories: [Category]
}

struct Category: Decodable {
    let subcategoryId: String
    let subcategoryName: String
    let products: [Product]

    enum CodingKeys: String, CodingKey {
        case subcategoryId = "subcategory_id"
        case subcategoryName = "subcategory_name"
        case products
    }
}

struct Product: Identifiable, Decodable {
    var id: String { productId }

    let productId: String
    let productName: String
    let productDetails: ProductDetails

    struct ProductDetails: Decodable {
        let brand: String
        let model: String
        let specs: Specs
        let features: [String]
        let price: Double
        let productImages: [String]

        struct Specs: Decodable {
            let display: String?
            let processor: String?
            let memory: String?
            let storage: String?
            let capacity: String?
            let energyRating: String?
            let dimensions: String?
        }
    }

    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case productName = "product_name"
        case productDetails = "product_details"
    }
}

// MARK: - Filtering Structures

struct ProductFilter {
    let brand: String?
    let minPrice: Double?
    let maxPrice: Double?
}

// MARK: - Parsing Function

func parseProducts(from jsonData: Data) -> [Product]? {
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let root = try decoder.decode(Root.self, from: jsonData)

        // Flatten all products from all categories
        let products = root.eCommercePlatform.categories.flatMap { category in
            category.products
        }

        return products
    } catch {
        print("Error decoding JSON: \(error)")
        return nil
    }
}

// MARK: - SwiftUI View

struct ProductListView: View {
    @State private var products: [Product] = []
    @State private var filteredProducts: [Product] = []
    @State private var selectedBrand: String? = nil
    @State private var minPrice: Double = 0
    @State private var maxPrice: Double = 2000

    var body: some View {
        NavigationView {
            VStack {
                // Filter Controls
                Form {
                    Section(header: Text("Filter Products")) {
                        Picker("Brand", selection: $selectedBrand) {
                            Text("All").tag(String?.none)
                            ForEach(products.uniqueBrands(), id: \.self) { brand in
                                Text(brand).tag(String?.some(brand))
                            }
                        }
                        .pickerStyle(MenuPickerStyle())

                        HStack {
                            Text("Min Price: $\(minPrice, specifier: "%.0f")")
                            Slider(value: $minPrice, in: 0...maxPrice, step: 50)
                        }

                        HStack {
                            Text("Max Price: $\(maxPrice, specifier: "%.0f")")
                            Slider(value: $maxPrice, in: minPrice...2000, step: 50)
                        }

                        Button("Apply Filters") {
                            applyFilters()
                        }
                    }
                }

                // Product List
                List(filteredProducts) { product in
                    HStack {
                        AsyncImage(url: URL(string: product.productDetails.productImages.first ?? "")) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 80, height: 80)
                            case .success(let image):
                                image.resizable()
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(8)
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.gray)
                            @unknown default:
                                EmptyView()
                            }
                        }

                        VStack(alignment: .leading) {
                            Text(product.productName)
                                .font(.headline)
                            Text(product.productDetails.brand)
                                .font(.subheadline)
                            Text("$\(product.productDetails.price, specifier: "%.2f")")
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Products")
            .onAppear {
                loadProducts()
            }
        }
    }

    // Load products from JSON
    func loadProducts() {
        // Replace with your actual JSON data source
        if let jsonData = jsonData, //.data(using: .utf8),
           let parsedProducts = parseProducts(from: jsonData) {
            self.products = parsedProducts
            self.filteredProducts = parsedProducts // Initially show all products
        }
    }

    // Apply filtering based on selected criteria
    func applyFilters() {
        filteredProducts = products.filter { product in
            var matches = true

            // Filter by Brand
            if let brand = selectedBrand {
                matches = matches && (product.productDetails.brand.lowercased() == brand.lowercased())
            }

            // Filter by Price Range
            let currentPrice = product.productDetails.price
            matches = matches && (currentPrice >= minPrice && currentPrice <= maxPrice)

            return matches
        }
    }
}

// MARK: - Array Extension for Unique Brands

extension Array where Element == Product {
    func uniqueBrands() -> [String] {
        let brands = self.map { $0.productDetails.brand }
        return Array(Set(brands)).sorted()
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}

// MARK: - Sample JSON Data

let jsonData = """
{
  "e_commerce_platform": {
    "categories": [
      {
        "subcategory_id": "SC1001",
        "subcategory_name": "mobile_phones",
        "products": [
          {
            "product_id": "P10001",
            "product_name": "Smartphone X200",
            "product_details": {
              "brand": "TechBrand",
              "model": "X200",
              "specs": {
                "display": "6.5-inch OLED",
                "processor": "Octa-core 2.8GHz",
                "memory": "8GB RAM",
                "storage": "128GB"
              },
              "features": ["5G Support", "Water Resistant", "Wireless Charging"],
              "price": 799.99,
              "product_images": [
                "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
                "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60"
              ]
            }
          },
          {
            "product_id": "P10002",
            "product_name": "Smartphone Y300",
            "product_details": {
              "brand": "InnovateTech",
              "model": "Y300",
              "specs": {
                "display": "6.1-inch LCD",
                "processor": "Hexa-core 2.4GHz",
                "memory": "6GB RAM",
                "storage": "64GB"
              },
              "features": ["Dual SIM", "Fast Charging", "Expandable Storage"],
              "price": 599.99,
              "product_images": [
                "https://images.unsplash.com/photo-1510552776732-7197b7450d4a?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
                "https://images.unsplash.com/photo-1523473827534-9ed832bfce09?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60"
              ]
            }
          }
        ]
      },
      {
        "subcategory_id": "SC1002",
        "subcategory_name": "laptops",
        "products": [
          {
            "product_id": "P10003",
            "product_name": "Laptop Pro 15",
            "product_details": {
              "brand": "ComputeX",
              "model": "Pro 15",
              "specs": {
                "display": "15.6-inch Retina",
                "processor": "Quad-core 3.1GHz",
                "memory": "16GB RAM",
                "storage": "512GB SSD"
              },
              "features": ["Touchscreen", "Backlit Keyboard", "Fingerprint Sensor"],
              "price": 1499.99,
              "product_images": [
                "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
                "https://images.unsplash.com/photo-1517430816045-df4b7de11d1d?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60"
              ]
            }
          }
        ]
      },
      {
        "subcategory_id": "SC2001",
        "subcategory_name": "refrigerators",
        "products": [
          {
            "product_id": "P20001",
            "product_name": "CoolFreeze 3000",
            "product_details": {
              "brand": "HomeEase",
              "model": "3000",
              "specs": {
                "capacity": "350L",
                "energy_rating": "A++",
                "dimensions": "70x70x180 cm"
              },
              "features": ["Frost Free", "Multi-Air Flow", "Smart Control"],
              "price": 1199.99,
              "product_images": [
                "https://images.unsplash.com/photo-1581579184890-0cb8a7a4ff35?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
                "https://images.unsplash.com/photo-1598300050364-50a204dc6eae?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60"
              ]
            }
          }
        ]
      }
    ]
  }
}
""".data(using: .utf8)
