//
//  SampleData.swift
//  ComplexJSONLevelsDemo
//
//  Created by Paul Solt on 12/18/24.
//


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
