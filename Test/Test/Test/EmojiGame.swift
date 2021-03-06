//
//  EmojiGame.swift
//  Test
//
//  Created by tdt on 2022/4/14.
//

import Foundation


func makecard (intdex : Int) -> String{
    return "π"
}
// η¨ζ₯θ‘¨η€ΊθΏδΈͺη±»δΌζΉεηι’

class EmojiGame : ObservableObject{
    
   static  var emojis=["π","π","π","π","π","π","π","π","π","π","π","π","π","π","π","π","π","π","π","πΆ","π"]
    //var Model : Game<String> = Game<String>(number: 4, creatCard: makecard)
   
    
    @Published var Model : Game<String> = Game<String>(number: 6) { index in
        emojis[index]
    }
    //θΏδΈͺε°ζΉε―δ»₯ζΏζ’δΈΊ,_ θΏδΈͺη¬¦ε·ζε³ηθΏιε―δ»₯εΏ½η₯οΌηΌθ―ε¨δΌθͺθ‘ζ¨ζ­
    
    //var Model : Game<String> = Game<String>(number: 4) {_ in "π}
    
    
    var cards: Array<Game<String>.Card>{
        return Model.cards
    }
    
    
  func choose(_ card :  Game<String>.Card){
      // η¨ζ₯ε·ζ°
      objectWillChange.send()
      print("emoji change")
      Model.choose( card: card )
    }
    
    func shuffle (){
        Model.shuffle()
    }
}
