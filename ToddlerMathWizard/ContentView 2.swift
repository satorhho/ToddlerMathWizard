//
//  ContentView.swift
//  ToddlerMathWizard
//
//  Created by Lance Kent Briones on 4/24/20.
//  Copyright © 2020 Lance Kent Briones. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // onAppear Alert State(s)
    
    // Stepper State(s)
    @State private var question_counter: Int = 1
    
    // Picker State(s)
    @State private var multiples: Int = 1
    
    
    var body: some View {
        NavigationView{
            ZStack{
                // Add some lit Gradient here
                VStack{
                    VStack(spacing: 10){
                        Text("Select the table you want to learn")
                        Stepper(value: $question_counter, in: 1...10, step: 1){
                            Text("\(self.question_counter)" + ((self.question_counter == 1) ? " Question" : " Questions"))
                        }
                        .padding()
                    }
                    
                    VStack(spacing: 10){
                        Text("Select the table you want to learn")
                        Picker(selection: $multiples, label: Text("Select Multiple")){ //multiples is off by 1
                            ForEach(0..<10){
                                Text("\($0 + 1)")
                            }
                        }
                        .labelsHidden()
                        .padding()
                    }
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
