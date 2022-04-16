
//  ContentView.swift
//  Test
//
//  Created by tdt on 2022/4/12.


import SwiftUI



struct ContentView: View {


    @ObservedObject var viewmodel : EmojiGame = EmojiGame()

    @State var dealt = Set<Int>()
    
    @Namespace var dealingNamespeace
    
    func deal (_ card:Game<String>.Card){
        dealt.insert(card.id)
    }
    
    func isUndealt (_ card: Game<String>.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    func dealAnimation(for card: Game<String>.Card) -> Animation{
        var delay=0.0
        if let index = viewmodel.cards.firstIndex(where: {$0.id == card.id}){
            delay=Double(index) * (1.0/Double(viewmodel.cards.count))
        }
        return Animation.easeInOut(duration: 1).delay(delay)
    }
    
    var body: some View {
        VStack{

            ScrollView{
                
                AspectVGrid(items: viewmodel.cards, aspectRatio: 2/3){
                //这里是输入值
                card in
                //这里是返回值
                    if isUndealt(card) || (card.isMathched && !card.isup){
                        Color.clear
                    }else{
                    CardView(card:  card ).aspectRatio(2/3,contentMode: .fit)
                            .padding(4)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespeace)
                        .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                        .onTapGesture {
                        withAnimation{
                        viewmodel.choose(card)
                        }
                    }
                }
                }
                
            }.foregroundColor(.gray)
                  
    }

        Spacer()

        
            ZStack{
                ForEach(viewmodel.cards.filter(isUndealt)){
                    card in
                    CardView(card: card).transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                        .matchedGeometryEffect(id: card.id, in: dealingNamespeace)
                }
            }.frame(width: 60, height: 90)
                .onTapGesture{
                    for card in viewmodel.cards {
                    withAnimation(dealAnimation(for: card)) {

                            deal(card)
                    }
                    }
                }
            
        Button("Shuffle"){
            //这里同样可以指定类型
            //magic！
            withAnimation(.easeInOut){
            viewmodel.shuffle()
            }
        }


        }
    }





struct CardView :View{

    var card : Game<String>.Card

    //或者使用init方法进行过变量的初始化，不然就必须在传参的时候指定变量名

    var body: some View{

        GeometryReader {
            geometry in
                    ZStack{
                        
                      
                        
                        let shape = RoundedRectangle (cornerRadius: DrawingConstants.cornerRadius)

                            Text(card.content)
                                .font(font(in: geometry.size))
                            //如果不加限制，这个动作会发生在一瞬间
                                .rotationEffect(Angle.degrees(
                                    card.isMathched ? 360 :0))
                                .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: false))
                            //常用隐式的动画选项：
                            //缓入缓出 ，spring，linear
//                            Pie(startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 80)).padding(7).opacity(0.5).foregroundColor(.blue)

                    }.cardify(isFaceUp: card.isup)


        }
    }



    func font(in size : CGSize) -> Font{

        Font.system(size:min(size.width, size.height) * DrawingConstants.fontScale)

    }


    struct DrawingConstants {

         static let cornerRadius : CGFloat = 20
         static let lineWidth : CGFloat = 3
         static let fontScale : CGFloat = 0.8

     }
}




struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        //为什么？？

        //var game = EmojiGame()
        ContentView().preferredColorScheme(.dark)
        ContentView().preferredColorScheme(.light)
    }
}
