//
//  ContentView.swift
//  lztrans
//
//  Created by jsw_cool on 2023/7/4.
//

import SwiftUI
import Moya

struct ContentView: View {
    @State var sublayoutArr:[Sublayout] = []
    
    var body: some View{
        NavigationView {
            ScrollView{
                VStack{
                    if $sublayoutArr.isEmpty{
                        Text("正在加载中")
                    }else{
                        if let sublayout = $sublayoutArr.first{
                            if let content = sublayout.content.first{
                                BannerView(bannerContent: content)
                            }
                        }
                        NoticeView()
                        CoreFuncView()
                        smallFuncView()
                            .padding(.horizontal)
                        AdView()
                        CommonHeaderView(title: "金融")
                            .padding(.horizontal)
                        FinanceView()
                        CommonHeaderView(title: "出行资讯")
                            .padding(.horizontal)
                        NewsView()
                    }
                }
            }
             .navigationTitle("道行龙城")
             .navigationBarTitleDisplayMode(.inline)
             .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    VStack(alignment: .leading){
                        Text("柳州市")
                        Text("多云 28℃")
                            .font(Font.system(size: 13.0))
                            .foregroundColor(Color.gray)
                    }
                }
             }
             .onAppear{
                 let provider = IndexAPI.getProvider()
                 provider.request(Index.index) { result in
                     switch result {
                         case let .success(moyaResponse):
                             let data = moyaResponse.data
                             let stringValue = String(decoding: data, as: UTF8.self)
                             let resultData = stringValue.data(using: .utf8)
                             let dict = try! JSONSerialization.jsonObject(with: resultData!, options: .allowFragments)
                             if let bizRes = (dict as AnyObject)["bizResp"]! as? String{
                                 let bizResData = bizRes.data(using: .utf8)
                                 let bizResDict = try! JSONSerialization.jsonObject(with: bizResData!, options: .allowFragments)
                                 if let res = bizResDict as? [String:Any]{
                                     if let arr1 = res["parentLayout"] as? [String:Any]{
                                         if let arr = arr1["subLayoutList"] as? [Any]{
                                             arr.forEach { item in
                                                 if let itemDic = item as? [String:Any]{
                                                     if let jsondata:Data = try? JSONSerialization.data(withJSONObject: itemDic){
                                                         guard let model:Sublayout = try? JSONDecoder().decode(Sublayout.self, from: jsondata) else {return}
                                                         sublayoutArr.append(model)
                                                     }
                                                 }
                                             }
                                         }
                                     }
                                 }
                             }
                         case let .failure(error):
                             print("error:\(error)")
                         }
                 }
             }
        }
    }
}

struct BannerView:View {

    @Binding var bannerContent:LLContent
    
    
    
    var body: some View{
        AsyncImage(url: URL(string: bannerContent.image)) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            Color.purple.opacity(0.1)
        }
        .frame(width: UIScreen.main.bounds.size.width-20, height: 120)
        .cornerRadius(20)
    }
}

struct NoticeView:View {
    
    var body: some View{
        HStack {
            Image("notice")
                .padding(.leading,6)
                .padding(.vertical,5)
            Text("城市自行车全市新增投放2万辆，今日6折骑行")
                .font(Font.system(size: 13.0))
                .foregroundColor(Color.gray)
            Spacer()
        }
        .background(Color.init(hexString: "#FFEDDA"))
        .cornerRadius(6.0)
        .padding(.horizontal,16)
    }
}

struct CoreFunc:Identifiable{
    var id = UUID()
    var imagesname:String
    var title:String
}

struct CoreFuncView:View{
    
    var corefuncs:[CoreFunc] = [
            CoreFunc(imagesname: "core1", title:"刷码乘车"),
            CoreFunc(imagesname: "core2", title:"实时公交"),
            CoreFunc(imagesname: "core3", title:"聚合打车"),
            CoreFunc(imagesname: "core4", title:"权益中心")
    ]
    
    var body: some View{
        LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]) {
            ForEach(corefuncs) { corefunc in
                VStack{
                    Image(corefunc.imagesname)
                        .resizable()
                        .frame(width: 50,height: 50)
                    Text(corefunc.title)
                        .font(Font.system(size: 13.0))
                        .foregroundColor(Color.gray)
                }
            }
        }
    }
}


struct smallFuncView:View {
    var smallfuncs:[CoreFunc] = [
            CoreFunc(imagesname: "small1", title:"实名登记"),
            CoreFunc(imagesname: "small2", title:"共享汽车"),
            CoreFunc(imagesname: "small3", title:"出租车"),
            CoreFunc(imagesname: "small4", title:"水上公交"),
            CoreFunc(imagesname: "small5", title:"汽车票"),
            CoreFunc(imagesname: "small1", title:"实名登记"),
            CoreFunc(imagesname: "small2", title:"共享汽车"),
            CoreFunc(imagesname: "small3", title:"出租车"),
            CoreFunc(imagesname: "small4", title:"水上公交"),
            CoreFunc(imagesname: "small1", title:"实名登记"),
            CoreFunc(imagesname: "small2", title:"共享汽车"),
            CoreFunc(imagesname: "small3", title:"出租车"),
            CoreFunc(imagesname: "small4", title:"水上公交")
    ]
    
    var body: some View{
        LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]) {
            ForEach(smallfuncs) { smallfunc in
                VStack{
                    Image(smallfunc.imagesname)
                        .resizable()
                        .frame(width: 40,height: 40)
                    Text(smallfunc.title)
                        .font(Font.system(size: 13.0))
                        .foregroundColor(Color.gray)
                }
            }
        }
    }
}

struct AdView:View {
    var body: some View{
        Image("ad")
            .resizable()
            .frame(width:UIScreen.main.bounds.size.width-24,height: 60)
    }
}

struct CommonHeaderView:View {
    var title:String

    var body: some View{
        HStack(alignment: .center){
            Text(title)
                .font(Font.title2)
                .fontWeight(Font.Weight.bold)
            Spacer()
            Text("查看全部")
                .font(Font.system(size: 13))
                .foregroundColor(Color.gray)
        }
    }
}

struct Finance:Identifiable{
    var id = UUID()
    var imagesname:String
    var title:String
    var des:String
}

struct FinanceView:View{
    
    var finances:[Finance] = [
            Finance(imagesname: "fin1", title: "贷款大师", des: "利率：1.30%/月"),
            Finance(imagesname: "fin2", title: "小黑鱼", des: "利率：1.30%/月"),
            Finance(imagesname: "fin3", title: "银豆钱", des: "利率：1.30%/月"),
            Finance(imagesname: "fin4", title: "小盈卡贷", des: "利率：1.30%/月"),
    ]
    
    var body: some View{
        LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]) {
            ForEach(finances) { finance in
                HStack{
                    VStack(alignment: .leading){
                        Text(finance.title)
                            .font(Font.system(size: 16))
                            .fontWeight(Font.Weight.bold)
                        Text(finance.des)
                            .font(Font.system(size: 13))
                            .foregroundColor(Color.gray)
                    }
                    Image(finance.imagesname)
                        .resizable()
                        .frame(width: 40,height: 40)
                }.padding(.vertical,10)
            }
        }
    }
}

struct News:Identifiable{
    var id = UUID()
    var imagesname:String
    var des:String
}

struct NewsView:View {
    var newsarr:[News] = [
        News(imagesname: "new1", des: "扩散！道行龙城“支付宝先乘后付”功能上线！乘坐公交快捷又方便~"),
        News(imagesname: "new2", des: "新功能 | 道行龙城 App 可以打出租车了？"),
        News(imagesname: "new3", des: "4月1日起，工商银行 20 万元“1分钱坐公交”补贴来袭！"),
        News(imagesname: "new4", des: "部分线路道行龙城POS机可刷柳州公交 IC 卡&市民卡啦！"),
        News(imagesname: "new5", des: "部分线路道行龙城POS机可刷柳州公交 IC 卡&市民卡啦！"),
        News(imagesname: "new6", des: "部分线路道行龙城POS机可刷柳州公交 IC 卡&市民卡啦！"),
    ]
    
    var body: some View{
        VStack{
            ForEach(newsarr) { news in
                HStack {
                    Text(news.des)
                    Spacer()
                    Image(news.imagesname)
                }
            }
        }
        .cornerRadius(12)
        .padding(.horizontal,16)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
