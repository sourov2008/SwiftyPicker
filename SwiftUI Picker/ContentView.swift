//
//  ContentView.swift
//  SwiftUI Picker
//
//  Created by Shourob Datta (Wipro Macbook) on 28/6/21.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented = false
    @State private var isPresentedItem = false


    @State var selectedDate = Date()
    @State var textField = ""
    let colors = ["Red","Yellow","Green","Blue"]
    @State var selectedType = 1

    var body: some View {
        VStack (alignment: .leading, spacing: 10){

            TextField("Enter Title", text: $textField)
                
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Show Date picker!") {
                isPresented.toggle()
            }
            Text("Selected Date : \(selectedDate.description)")
            //Spacer()
            .fullScreenCover(isPresented: $isPresented){
                DateTimePicker(selectedDate: $selectedDate)
            }
            
            
            
            Button("Show list picker!") {
                isPresentedItem.toggle()
            }
            
            Text("Selected Color : \(colors[selectedType].description)")
            //Spacer()
            .fullScreenCover(isPresented: $isPresentedItem){
                ItemPicker(selection: $selectedType,colors: colors)
            }
            
            Spacer()

            
        }
        .padding()

    }
}

struct ItemPicker: View {
    @Environment(\.presentationMode) var presentationMode

    @Binding var selection : Int
    var colors = [String]()

    var body: some View {
        VStack {
            Spacer()
            Picker(selection: $selection, label:
            Text("Picker Name")) {
                ForEach(0 ..< colors.count) { index in
                    Text(self.colors[index]).tag(index)
                }
            }
            //.frame(width: 250, height: 500)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            
        }
        .background(BackgroundCleanerView())
        .onTapGesture {
            presentationMode.wrappedValue.dismiss()
        }
        .onChange(of: selection, perform: { value in
            presentationMode.wrappedValue.dismiss()
        })
         //Here is where we use the opacity


    }
}


struct DateTimePicker: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedDate : Date
    
    var body: some View {
        VStack {

            Spacer()
            HStack{
                Spacer()
                Button.init(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Done")
                        .foregroundColor(.red)
                        .font(.subheadline)
                })
                .padding(.horizontal)

            }
            
            DatePicker("Date time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(GraphicalDatePickerStyle())
            
        }
        .background(BackgroundCleanerView())
    }
}

struct BackgroundCleanerView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
   
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

