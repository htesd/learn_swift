//
//  ContentView.swift
//  Test
//
//  Created by tdt on 2022/4/12.
//

//import SwiftUI
//
//
//
//struct ContentView: View {
//
//
//    @ObservedObject var viewmodel : EmojiGame = EmojiGame()
//
//
//
//    var body: some View {
//        VStack{
//
//            ScrollView{
//            LazyVGrid(columns: [GridItem(),GridItem(),GridItem(),GridItem()]){
//                ForEach(viewmodel.cards) {
//                //这里是输入值
//                card in
//                //这里是返回值
//                    CardView(card:  card ).aspectRatio(2/3,contentMode: .fit)
//                        .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity))
//                        .onTapGesture {
//                        withAnimation{
//                        viewmodel.choose(card)
//                        }
//                }
//            }
//            }.foregroundColor(.gray)
//    }
//
//        Spacer()
//
//
//        Button("Shuffle"){
//            //这里同样可以指定类型
//            //magic！
//            withAnimation(.easeInOut){
//            viewmodel.shuffle()
//            }
//        }
//
//
//        }
//    }
//}
//
//
//
//
//struct CardView :View{
//
//    var card : Game<String>.Card
//
//    //或者使用init方法进行过变量的初始化，不然就必须在传参的时候指定变量名
//
//    var body: some View{
//
//        GeometryReader {
//            geometry in
//                    ZStack{
//                        let shape = RoundedRectangle (cornerRadius: DrawingConstants.cornerRadius)
//
//                            Text(card.content)
//                                .font(font(in: geometry.size))
//                            //如果不加限制，这个动作会发生在一瞬间
//                                .rotationEffect(Angle.degrees(
//                                    card.isMathched ? 360 :0))
//                                .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: false))
//                            //常用隐式的动画选项：
//                            //缓入缓出 ，spring，linear
//                            Pie(startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 80)).padding(7).opacity(0.5).foregroundColor(.blue)
//
//                    }.cardify(isFaceUp: card.isup)
//
//
//        }
//    }
//
//
//
//    func font(in size : CGSize) -> Font{
//
//        Font.system(size:min(size.width, size.height) * DrawingConstants.fontScale)
//
//    }
//
//
//    struct DrawingConstants {
//
//         static let cornerRadius : CGFloat = 20
//         static let lineWidth : CGFloat = 3
//         static let fontScale : CGFloat = 0.8
//
//     }
//}
//
//
//
//
//struct ContentView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        //为什么？？
//
//        //var game = EmojiGame()
//        ContentView().preferredColorScheme(.dark)
//        ContentView().preferredColorScheme(.light)
//    }
//}
