//
//  DetailView.swift
//  Crypto
//
//  Created by Victor  on 29.11.2022.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: Coin?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                    DetailView(coin: coin)
            }
        }
    }
}
 
struct DetailView: View {
    @StateObject private var vm: DetailViewModel
    @State private var showFullDescription: Bool = false
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    private let spacing: CGFloat = 30

    init(coin: Coin) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
     
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                
                VStack(spacing: 20) {
                    overviewTitle
                    Divider()
                    descriptionSection
                    overviewGrid
                    additionalTitle
                    additionalGrid
                    websiteSection
                }
                .padding()
            }
        }
        .background(
            Color.theme.background
                .ignoresSafeArea()
        )
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItems
            }
        }
    }
}

extension DetailView {
    private var navigationBarTrailingItems: some View {
        HStack {
             Text(vm.coin.symbol.uppercased())
                .font(.headline)
            .foregroundColor(Color.theme.secondaryText)
			CoinImageViewSwiftUI(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var descriptionSection: some View {
        ZStack {
            if let coinDescription = vm.coinDescription,
               !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryText)
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Less" : "Read more.." )
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    }
                    .accentColor(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var overviewGrid: some View {
        LazyVGrid(
            columns: columns ,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(vm.overviewStatistics) { stat in
                    StatisticView(stat: stat)
                }
            })
    }
    
    private var additionalGrid: some View {
        LazyVGrid(
            columns: columns ,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(vm.additionalStatistics) { stat in
                    StatisticView(stat: stat)
                }
            })
    }
    
    private var websiteSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let websiteString = vm.websiteURL,
            let url = URL(string: websiteString){
                 Link("Website", destination: url)
            }
            if let redditString = vm.redditURL,
            let url = URL(string: redditString){
                 Link("Reddit", destination: url)
            }
        }
        .accentColor(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Group {
                DetailView(coin: dev.coin)
            }
        }
    }
}


struct CoinImageViewSwiftUI: UIViewRepresentable {
	let coin: Coin
	
	init(coin: Coin) {
		self.coin = coin
	}
	
	func makeUIView(context: Context) -> CoinImageView {
		let coinImageView = CoinImageView(coin: coin)
		return coinImageView
	}
	
	func updateUIView(_ uiView: CoinImageView, context: Context) {}
}
