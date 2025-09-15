import SwiftUI

struct DailyTipView: View {
    let dailyTips = [
        "Track your expenses daily to avoid surprises.",
        "Set a savings goal and pay yourself first.",
        "Avoid impulse purchases—wait 24 hours before buying.",
        "Negotiate your bills—you’d be surprised how often it works.",
        "Automate savings so you don’t have to think about it.",
        "Stick to a budget that fits your income.",
        "Review your subscriptions and cancel unused ones."
    ]
    
    @State private var currentTip: String = ""
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 123/255, green: 44/255, blue: 191/255),   // Purple
                    Color(red: 244/255, green: 166/255, blue: 152/255)   // Soft Peach
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack(spacing: 16) {
                    Text("💡 Daily Tip")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    Text(currentTip)
                        .font(.headline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(
                            Color.white.opacity(0.2)
                                .blur(radius: 10)
                                .background(.ultraThinMaterial)
                        )
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                        .transition(.move(edge: .trailing))
                        .id(currentTip)
                    
                    Button {
                        withAnimation {
                            currentTip = dailyTips.randomElement() ?? ""
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise.circle.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(
                                Color.white,
                                Color(red: 244/255, green: 166/255, blue: 152/255) // Soft Peach
                            )
                            .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 3)
                    }
                    .padding(.top, 10)
                }
                .padding()
                .background(
                    Color.white.opacity(0.15)
                        .blur(radius: 10)
                        .background(.ultraThinMaterial)
                )
                .cornerRadius(30)
                .padding(.horizontal, 30)
                .padding(.bottom, 50)
                
                Spacer()
            }
        }
        .onAppear {
            currentTip = dailyTips.randomElement() ?? ""
        }
    }
}

#Preview {
    DailyTipView()
}
