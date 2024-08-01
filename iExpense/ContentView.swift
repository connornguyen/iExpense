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
struct ExpenseItem : Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}
// class of expense
@Observable
class Expenses {
    var items = [ExpenseItem]()
}
//Main view
struct ContentView: View {
    //to keep using class Expense insinde the struct
    @State private var expenses = Expenses()
  
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
                    let expense = ExpenseItem(name: "Expense1", type: "Personal", amount: 4)
                    expenses.items.append(expense)
                }
            }  //add a "add expense" on top-right corner
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
