import SwiftUI

struct PickupView: View {
    
    @StateObject private var viewModel = PickupViewModel()
    
    @Binding var isShowTabBar: Bool
    
    @State private var selectedPoint: PickupPoint?
    @State private var isShowDetailView = false
    @State private var isShowFavorites = false
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(.Images.BG)
                    .baseResizable()
                
                VStack {
                    navigation
                    
                    VStack(spacing: 8) {
                        searchInput
                        
                        if viewModel.filteredPoints.isEmpty {
                            stumb
                        } else {
                            points
                        }
                    }
                    .padding(.top, 16)
                    .padding(.horizontal, 35)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 20)
            }
            .navigationDestination(isPresented: $isShowDetailView) {
                PickupPointDetail(
                    pickup: selectedPoint ?? PickupPoint.mocks.first!,
                    favorites: viewModel.favoritesPoints) { point in
                        viewModel.saveFavorite(point)
                    }
            }
            .navigationDestination(isPresented: $isShowFavorites) {
                PickupFavoritesView(points: viewModel.favoritesPoints)
            }
            .onAppear {
                viewModel.loadFavorites()
                isShowTabBar = true
            }
            .onChange(of: viewModel.isCloseNavigation) { isClose in
                if isClose {
                    isShowFavorites = false
                    isShowDetailView = false
                    viewModel.isCloseNavigation = false
                    selectedPoint = nil
                }
            }
        }
    }
    
    private var navigation: some View {
        ZStack {
            Text("Pickup Points")
                .font(.impact(with: 35))
                .foregroundStyle(.sgDarkRed)
            
            HStack {
                Button {
                    isShowTabBar = false
                    isShowFavorites.toggle()
                } label: {
                    RoundedRectangle(cornerRadius: 17)
                        .foregroundStyle(.sgPink)
                        .frame(width: 44, height: 44)
                        .overlay {
                            Image(systemName: "heart")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundStyle(.white)
                        }
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, 35)
        }
    }
    
    private var searchInput: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(.gray.opacity(0.5))
            
            TextField("", text: $viewModel.searchedText, prompt: Text("Search by name or city")
                .foregroundColor(.gray.opacity(0.5)))
            .font(.impact(with: 16))
            .foregroundStyle(.black)
            .focused($isFocused)
            
            if viewModel.searchedText != "" {
                Button {
                    viewModel.searchedText = ""
                    isFocused = false
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.gray.opacity(0.5))
                }
            }
        }
        .frame(height: 65)
        .padding(.horizontal, 20)
        .background(.white)
        .cornerRadius(33)
    }
    
    private var points: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 8) {
                ForEach(viewModel.filteredPoints) { point in
                    PointListCellView(point: point) {
                        isShowTabBar = false
                        selectedPoint = point
                        isShowDetailView = true
                    }
                }
            }
        }
        .padding(.bottom, 110)
    }
    
    private var stumb: some View {
        VStack {
            Image(.Images.Pickup.stumb)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 104)
            
            VStack(spacing: 16) {
                Text("Nothing found")
                    .font(.impact(with: 32))
                    .foregroundStyle(.sgDarkRed)
                
                Text("Sorry, your request for sweets was not found. Try to change the name or check spelling")
                    .font(.impact(with: 16))
                    .foregroundStyle(.sgDarkRed.opacity(0.75))
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, 8)
    }
}

#Preview {
    PickupView(isShowTabBar: .constant(false))
}

