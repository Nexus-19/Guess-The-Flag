//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Soumyattam Dey on 20/06/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var inCorrect=0
    
    @State private var showingScore=false
    @State private var scoreTitle=""
    @State private var score=0
    
    
    var body: some View {
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [.blue,.green]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack(spacing:30){
                
                VStack{
                    Text("Tap the flag of:")
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                .foregroundColor(.white)
                
                ForEach(0..<3){number in
                    Button(action: {
                        flagTapped(number)
                    }, label: {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black,lineWidth: 0.5))
                            .shadow(radius: 5)
                    })
                }
                
                Text("Your Score is : \(score)")
                    .font(.title)
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .alert(isPresented: $showingScore){
            Alert(title: Text("\(scoreTitle)!Thats the flag of \(countries[inCorrect])"), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")){
                newGame()
            })
        }
    }
    
    func flagTapped(_ number:Int){
        if(number==correctAnswer){
            scoreTitle="Correct"
            score+=1
            newGame()
        }else{
            scoreTitle="Incorrect"
            inCorrect=number
            showingScore=true
        }
    }
    
    func newGame(){
        countries.shuffle()
        correctAnswer=Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
