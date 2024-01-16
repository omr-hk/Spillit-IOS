//
//  ThreadsView.swift
//  Spillit-IOS
//
//  Created by Omar Hassan on 14/01/24.
//

import SwiftUI

struct ThreadsView: View {
    @ObservedObject var tvm: ThreadsViewModel = .shared
    @Binding var page: PageLocation
    let spacename: String = "scroll"
    @State var wholeSize: CGSize = .zero
    @State var scrollViewSize: CGSize = .zero
    var body: some View {
        switch tvm.state.0{
        case .loaded:
            if tvm.notes.isEmpty{
                EmptyThreadsView()
            }
            else{
                ScrollView(showsIndicators: false){
                    LazyVStack{
                        ForEach(tvm.notes, id: \.self){ note in
                            ThreadView(note: note)
                            
                        }
                        Color.clear
                            .frame(width: 0, height: 0, alignment: .bottom)
                            .onAppear {
                                print("Fetching more data")
                                Task{
                                    await tvm.nextFetch()
                                    print(tvm.state.1)
                                }
                            }
                    }
                }
            }
            
        case .loading:
            LoadingThreadsView()
        case .error:
            LoadingThreadsView()
                .onAppear{
                    page = .error
                }
        }
        
    }
}
