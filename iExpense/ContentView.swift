//
//  ContentView.swift
//  iExpense
//
//  Created by Apple on 01/08/2024.
//

import Observation
import SwiftUI

// Attribute of ExpenseItem
// with : Identifiable *it requires unique ID(UUID,String, Int,...), it tells swift that this ExpenseItem is unique, so that we dont need to tell ForEach how to identifie itself.
struct ExpenseItem : Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
// class of expense
@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet{
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let saveItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: saveItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}
//Main view
struct ContentView: View {
    //to keep using class Expense insinde the struct
    @State private var expenses = Expenses()
    
    @State private var isShowingAddView = false
  
    var body: some View {
        NavigationStack{
            List{
                ForEach(expenses.items){ item in
                    Text(item.name)
                    
                }
                .onDelete(perform: removeItem) // delete function applied here
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add expense", systemImage: "plus"){
                    isShowingAddView = true
                }
            }//add a "add expense" on top-right corner
            .sheet(isPresented: $isShowingAddView) {
                AddView(expenses: expenses) //Linked expenses from both files
            }
        }
        
    }
    //function to remove an expense
    func removeItem(at offset: IndexSet){
        expenses.items.remove(atOffsets: offset)
    }
    
    
}

#Preview {
    ContentView()
}
