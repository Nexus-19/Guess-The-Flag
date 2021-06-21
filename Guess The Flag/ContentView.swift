//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Soumyattam Dey on 20/06/21.
//

import SwiftUI


struct ContentView: View {
    
    //Array to store the names of the countries that shuffles everytime the app starts
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)    //index for the correct answer
    @State private var inCorrect=0      //index for the answer chosen by user if the answer is incorrect
    
    @State private var showingScore=false   //state property for initializing the alert modifier
    @State private var scoreTitle=""        //Stating if answer is correct or not
    @State private var score=0              //Calculting the score of the player
    @State private var outcome="Let's Play!"
    
    
    var body: some View {
        ZStack{
            //Background color
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
                
                //ForEach view creates desired views in a loop
                ForEach(0..<3){number in
                    Button(action: {
                        flagTapped(number)      //function is called
                    }, label: {
                        Image(self.countries[number])   //three buttons view images from the shuffled array
                            .renderingMode(.original)   //renders original image and not colores for the button
                            .clipShape(Capsule())       //for capsule shape
                            .overlay(Capsule().stroke(Color.black,lineWidth: 0.5))      //creates an outline
                            .shadow(radius: 5)          //created a shadow effect
                    })
                }
                
                Text("Your Score is : \(score)")
                    .font(.title)
                    .foregroundColor(.white)
                
                Text(outcome)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
            }
        }
        .alert(isPresented: $showingScore){
            Alert(title: Text("\(scoreTitle)Thats the flag of \(countries[inCorrect])"), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")){
                newGame()   //it is the defalut closure.It is called when continue is tapped
            })
        }
        //alert gets involked when 'showingScore' turns true and toggles back to false when alert is shown
    }
    
    //function to check if the answer is correct or not
    func flagTapped(_ number:Int){
        if(number==correctAnswer){
            scoreTitle="Correct!"
            outcome="Correct!"
            score+=1
            newGame()
        }else{
            scoreTitle="Incorrect!"
            outcome="Incorrect!"
            inCorrect=number
            showingScore=true
        }
    }
    
    //function to reshuffle the array for new flags
    func newGame(){
        countries.shuffle()         //   NOTE:   here shuffle is used while earlier shuffled was used
        correctAnswer=Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
