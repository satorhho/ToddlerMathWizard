//
//  ContentView.swift
//  ToddlerMathWizard
//
//  Created by Lance Kent Briones on 4/24/20.
//  Copyright © 2020 Lance Kent Briones. All rights reserved.
//

import SwiftUI
struct SpinButton: ViewModifier {
    let rotation_amount: Double
    func body(content: Content) -> some View {
        content.rotation3DEffect(.degrees(self.rotation_amount), axis: (x: 0, y: 1, z: 0))
    }
}
struct SpinDiff: ViewModifier {
    let rotation_amount: Double
    func body(content: Content) -> some View {
        content.rotation3DEffect(.degrees(self.rotation_amount), axis: (x: 1, y: 0, z: 0))
    }
}
extension View {
    func spinButton(rval: Double) -> some View {
        self.modifier(SpinButton(rotation_amount: rval))
    }
    func spinDiff(rval: Double) -> some View {
        self.modifier(SpinDiff(rotation_amount: rval))
    }
    func decide(boolean: Bool, doubleValue: Double, opacityValue: Double) -> some View{
        if boolean {
            return AnyView(self.modifier(SpinButton(rotation_amount: doubleValue)))
        }
        else {
            return AnyView(self.modifier(SpinDiff(rotation_amount: opacityValue)))
        }
    }
}
struct ContentView: View {
    // onAppear Alert State(s)
    
    // Stepper State(s)
    @State private var question_counter: Int = 1
    
    // Picker State(s)
    @State private var multiple: Int = 1
    
    // Question State(s)
    @State private var multiple_answers = [69, 69, 69]  // automatically shuffled
    /*
    var answer_modifier: [Int] {
        get {
            return self.multiple_answers
        }
        set(multipleOf){
            var store = [Int]()
            
            for i in 1...10{
                store.append(i)
            }
            
            return multiple_answers = store.shuffled()
        }
    }
    */
    // self.multiple also functions as X
    @State private var Y: Int = Int.random(in: 0...10)  // answer is self.multiple_answers[self.Y]
    @State private var rand: Int = Int.random(in: 0..<3)
    
    // Alert State(s)
    @State private var show_alert: Bool = true
    @State private var alert_title: String = "NANI DA FAK?!"
    @State private var alert_message: String = "I NEED TO GET A LIFE LOL"
    
    // Animation State(s)
    @State private var rotation_amout: Double = 0.0
    
    // Point State(s)
    @State private var points = 0
    
    
    var body: some View {
        NavigationView{
            ZStack{
                RadialGradient(gradient: Gradient(colors: [Color(red: 1, green: 0.412, blue: 0.706), .purple, .blue, Color(red: 0.529, green: 0.808, blue: 0.922), Color(red: 0.565, green: 0.933, blue: 0.565)]), center: .bottomLeading, startRadius: 850, endRadius: 200)
                    .edgesIgnoringSafeArea(.all)
                VStack{

                    //Text("Select the table you want to learn")
                    Stepper(value: $question_counter, in: 1...10, step: 1){
                        Text("\(self.question_counter)" + ((self.question_counter == 1) ? " Question" : " Questions"))
                    }
                    .padding()

                    
                    //Text("Multiples of?")
                    Picker(selection: $multiple, label: Text("Select Multiple")){ //multiples is off by 1
                        ForEach(0..<10){
                            Text("\($0 + 1)")
                        }
                    }
                    .padding(12.8)
                        
                    Spacer()
                    
                    VStack{
                        Text("<THISSECTIONISNOTYETIMPORTANT>")
                        Text("WHAT IS..")
                        Text(String(self.multiple + 1) + "*" + String(self.Y))
                        Text("</THISSECTIONISNOTYETIMPORTANT>")
                        
                    }
                    
                    HStack{
                        ForEach(0..<3){ i in
                            
                            Button(action: {
                                self.tapped(button_value: i)
                                withAnimation(.interpolatingSpring(stiffness: 10, damping: 4)){
                                    self.rotation_amout += 360
                                }
                            }){
                                Text("\(self.multiple_answers[i])")
                                .padding(50)
                                .background(LinearGradient(gradient: Gradient(colors: [.black, .gray, .white]), startPoint: .top, endPoint: .bottom))
                                .foregroundColor(.red)
                                .font(.largeTitle)
                                .clipShape(Circle())
                                
                            }
                            .spinButton(rval: self.rotation_amout)
                            
                            
                        }
                    }
                    
                    Spacer()
                    
                }
            }
            .navigationBarTitle("ToddlerMathWizard", displayMode: .large)
            .alert(isPresented: $show_alert){
                Alert(title: Text(self.alert_title), message: Text(self.alert_message), dismissButton: .default(Text("Okay")))
                
            }            
        }
    }
    func shuffle_array(multipleOf: Int = 5) -> Void {
        var store = [Int]()
        
        for i in 1...10{
            store.append(i * 5)
        }
        
        self.multiple_answers = store.shuffled()
    }
    func change_alert(title: String, message: String) -> Void {
        self.alert_title = title
        self.alert_message = message
        //self.show_alert = true
    }
    func ask_question() -> Void {
        //self.multiple_answers.shuffle()
    }
    func tapped(button_value: Int) -> Void{
        self.shuffle_array()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
