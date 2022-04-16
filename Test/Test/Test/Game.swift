//
//  Game.swift
//  Test
//
//  Created by tdt on 2022/4/14.
//
// 这个包含了常用的数据结构和之前的包不一样

import Foundation
import CloudKit
import SwiftUI

struct Game<T> where T : Equatable{
     // swift 总是希望变量是有值的 除非使用optional
    
    // 利用计算特性来获取数值
    var indeOfTheFaceup: Int?{
        get {
            // power of function
            cards.indices.filter({index in cards[index].isup}).oneAndOnly
            // ! extension
        }
        set{
                //这个用来表示输入值
            cards.indices.forEach{cards[$0].isup = ($0 == newValue)}
        }
    }
    
    var cards : Array <Card>
    // 箭头可以表示返回值
    // 用来表示这个函数正在改变某些变量
    mutating func choose( card : Card) {
        
        if let cardindex = index(of: card) ,
           !cards[cardindex].isup,
           !cards[cardindex].isMathched {
            if let potentialMatchIndex = indeOfTheFaceup {
                if cards[cardindex].content == cards[potentialMatchIndex].content{
                    cards[cardindex].isMathched=true
                    cards[potentialMatchIndex].isMathched=true
                }
                cards[cardindex].isup = true
            }else{
                indeOfTheFaceup = cardindex
            }
            
            
            
            print("card = \( cards[cardindex].id)")
        }

    }
    
    
    mutating func shuffle (){
        cards.shuffle()
    }
    
    
    func index (of : Card) -> Int?{
        for index in 0..<cards.count{
            
            if cards[index].id == of.id {
                return index
            }
        }
      
            return nil
       
    }
    
    init (number : Int, creatCard: (Int) -> T){
        
        cards=Array <Card>()
        
        for i in 0..<number{
            
            let content = creatCard(i)
            
            cards.append(Card(id : i*2, content: content))
            cards.append(Card(id : i*2+1, content: content))
        }
    }
    
    struct Card : Identifiable{
        var id: Int
        var isup : Bool = false
        var isMathched : Bool = false
        var content : T
        
    }
    
}

extension Array {
    var oneAndOnly : Element? {
        if self.count == 1 {
            return self.first
        } else{
            return nil
        }
    }
}

