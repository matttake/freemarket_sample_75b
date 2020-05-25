# カテゴリデータの導入

lady = Category.create(name: "レディース")
lady_1 = lady.children.create(name: "トップス")
lady_1.children.create([{name: "Tシャツ/カットソー(半袖/袖なし)"},{name: "Tシャツ/カットソー(七分/長袖)"}])
lady_2 = lady.children.create(name: "ジャケット/アウター")
lady_2.children.create([{name: "テーラードジャケット"},{name: "Gジャン/デニムジャケット"}])

men = Category.create(name: "メンズ")
men_1 = men.children.create(name: "トップス")
men_1.children.create([{name: "Tシャツ/カットソー(半袖/袖なし)"},{name: "Tシャツ/カットソー(七分/長袖)"}])
men_2 = men.children.create(name: "ジャケット/アウター")
men_2.children.create([{name: "テーラードジャケット"},{name: "Gジャン/デニムジャケット"}])
