
import SwiftUI

struct CountdownTimerView: View {
    let totalDays: Int
    let daysLeft: Int
    let customText: String
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(totalDays: Int, daysLeft: Int, customText: String) {
        self.totalDays = totalDays
        self.daysLeft = daysLeft
        self.customText = customText
    }

    var body: some View {
        VStack {
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: 20))
                    .frame(width: 200, height: 200)

                Circle()
                    .trim(from: CGFloat(1 - Double(daysLeft) / Double(totalDays)), to: 1)
                    .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .frame(width: 200, height: 200)
                
                Text(customText)
<<<<<<< Updated upstream
                    .font(.system(size:108))
=======
                    .font(.system(size: 108))
>>>>>>> Stashed changes
                    .bold()
            }
            switch daysLeft {
                case 1:
                    Text("\(daysLeft) day left")
                        .font(.headline)
                        .padding()
                        .offset(y:20)
                case let x where x < 1:
                    Text("This item has expired!")
                        .font(.headline)
                        .padding()
                        .offset(y:20)
                default:
                    Text("\(daysLeft) days left")
                        .font(.headline)
                        .padding()
                        .offset(y:20)
            }

        }
        .onReceive(timer) { _ in
            // Update logic based on timer if needed
        }
    }
}

struct CountdownTimerView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownTimerView(totalDays: 10, daysLeft: 0, customText: "")
    }
}
