//
//  InventoryView.swift
//  Ghala
//
//  Created by mroot on 19/05/2022.
//

import SwiftUI

struct InventoryView: View {
    @ObservedObject var inventoryService = InventoryService()
    @ObservedObject var user: User
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    //Filter View
                    FilterView()
                    //Inventory List
                    List {
                        ForEach(inventoryService.inventory, id: \.sku) { inventoryItem in
                            InventoryCell(name: inventoryItem.name, category: inventoryItem.category, SKU: inventoryItem.skuCode, price: inventoryItem.ppu, quantity: inventoryItem.quantity, status: inventoryItem.status)
                                .padding()
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        }.listRowBackground(Color.clear)
                            .background(Color.listBackground)
                    }.listStyle(SidebarListStyle())
                    .refreshable {
                        Task {
                            await getAll()
                        }
                    }
                }.navigationTitle("Inventory")
            //Add Inventory Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        //to Add Inventory
                        NavigationLink(destination: AddInventory(inventoryD: InventoryEncode(), user: user)) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.yellow)
                                .padding()
                        }
                    }
                }
            }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(systemName: "magnifyingglass")
                    }
                }
        }.task {
            await getAll()
        }
    }
    //getAllItems
    func getAll() async {
        do {
            try await inventoryService.getAllInventory()
        } catch {
            print(error)
        }
    }
}

struct InventoryView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryView(user: User())
    }
}