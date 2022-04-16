//
//  EmojiGame.swift
//  Test
//
//  Created by tdt on 2022/4/14.
//

import Foundation


func makecard (intdex : Int) -> String{
    return "😅"
}
// 用来表示这个类会改变界面

class EmojiGame : ObservableObject{
    
   static  var emojis=["😀","😁","😂","😃","😄","😅","😆","😉","😊","😋","😎","😍","😘","😗","😙","😚","😇","😐","😑","😶","😏"]
    //var Model : Game<String> = Game<String>(number: 4, creatCard: makecard)
   
    
    @Published var Model : Game<String> = Game<String>(number: 6) { index in
        emojis[index]
    }
    //这个地方可以替换为,_ 这个符号意味着这里可以忽略，编译器会自行推断
    
    //var Model : Game<String> = Game<String>(number: 4) {_ in "😅}
    
    
    var cards: Array<Game<String>.Card>{
        return Model.cards
    }
    
    
  func choose(_ card :  Game<String>.Card){
      // 用来刷新
      objectWillChange.send()
      print("emoji change")
      Model.choose( card: card )
    }
    
    func shuffle (){
        Model.shuffle()
    }
}
