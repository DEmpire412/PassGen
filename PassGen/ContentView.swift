//
//  ContentView.swift
//  PassGen
//

//SwiftUI library is built into Xcode
import SwiftUI

struct ContentView: View {
    //Initializes string variables
    @State private var inputtedPW: String = ""
    @State private var createdPW: String = ""
    
    //Front-End view code
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Text("PassGen")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 20))
                    
                    Text("Please enter a word or phrase you would like to turn into a strong password.")
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20))
                    
                    Image(systemName: "key")
                        .foregroundColor(Color.blue)
                        .font(.system(size: 64.0))
                    
                    TextField("Enter word/phrase", text: $inputtedPW)
                        .textFieldStyle(.roundedBorder)
                        .padding(20)
                    
                    //Button to activate generate function (OS-specific design)
                    #if os(iOS)
                    Button(action: generatePassword) {
                        Text("Generate Password")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.vertical, 15)
                            .padding(.horizontal, 40)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(20)
                    #endif
                    
                    #if os(macOS)
                    Button(action: generatePassword) {
                        Text("Generate Password")
                            .fontWeight(.bold)
                            .buttonStyle(.bordered)
                            .padding(20)
                    }
                    #endif
                    
                    VStack{
                        Text("Created Password: ")
                        Text("\(createdPW)")
                            .fontWeight(.bold)
                            .font(.title)
                            .background(.primary)
                            .textSelection(.enabled)
                            .padding(20)
                    }
                    
                    //Button to activate clear function
                    Button(action: clearPassword) {
                        Text("Clear")
                            .buttonStyle(.bordered)
                            .padding(20)
                    }
                }.frame(minHeight: geometry.size.height)
            }
        }
    }
    
    //Functions to modify inputted string to generate password
    func generatePassword() {
        let createdPWArray = modifyPassword(Array(inputtedPW))
        let shuffledPWArray = createdPWArray.shuffled()
        createdPW = String(shuffledPWArray)
    }
    
    func modifyPassword(_ password: [Character]) -> [Character] {
        var createdPW = password
        let replacements: [(Character, Character)] = [("a", "@"), ("e", "3"), ("i", "!"), ("o", "0"), ("s", "$"), ("l", "1")]
        for (index, char) in createdPW.enumerated() {
            for (oldChar, newChar) in replacements {
                if char == oldChar && Bool.random() {
                    createdPW[index] = newChar
                    break
                }
            }
        }
        return createdPW
    }
    
    //Function to clear password
    func clearPassword() {
        inputtedPW = ""
        createdPW = ""
    }
}

//Preview engine; allows previewing of app without fully compiling it each time (built into Xcode)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
