//
//  Mone.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/09/18.
//

import SwiftUI

struct Mone: View {
    @SceneStorage("isZooming") var isZooming: Bool = false
    
    @Environment(\.managedObjectContext)
    private var context
    @ObservedObject var samples : SampleData

    var body: some View {
        
//        ScrollView(.vertical, showsIndicators: false) {
        ScrollView {

//            VStack {
//                Image("car")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: getRect().width - 30, height: 250)
//                    .cornerRadius(15)
//                    .addPinchZoom()
                
                Text(samples.wrappedText)
                    .frame(width: 350)
                if samples.image1?.count ?? 0
                    != 0 {
                        Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
//                            .frame(width: getRect().width - 30, height: 250)
                            .frame(width: getRect().width - 30)
                            .addPinchZoom()
                        }
                
//            }
//            .padding()
        }
        .safeAreaInset(edge: .top) {
            HStack {
//                Button {
                    
//                } label: {
//                    Image(systemName: "camera.fill")
//                }
                
                Spacer()
                
//                Button {
                    
//                } label: {
//                    Image(systemName: "paperplane.fill")
//               }
            }
            .overlay {
//                Text("Instagram")
                Text(samples.wrappedDate,
                     formatter: itemFormatter)
//                    .font(.title3.bold())
            }
            .padding()
            .foregroundColor(.primary)
            .background(.ultraThinMaterial)
            .offset(y: isZooming ? -200 : 0)
            .animation(.easeInOut, value: isZooming)
        }
    }
    let itemFormatter: DateFormatter = {
       let formatter = DateFormatter()
       formatter.calendar = Calendar(identifier: .gregorian)
       formatter.locale = Locale(identifier: "ja_JP")
       formatter.dateStyle = .long
       formatter.timeStyle = .none
       formatter.dateFormat = "yyyy年MM月dd日"
       return formatter
   }()
    
}

//struct Mone_Previews: PreviewProvider {
//    static var previews: some View {
//        Mone( samples:  SampleData())
//            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}

extension View {
    func addPinchZoom()->some View {
        return PinchZoomContext {
            self
        }
    }
}

struct PinchZoomContext<Content: View>: View {
    
    var content: Content
    
    init(@ViewBuilder content: @escaping ()->Content){
        self.content = content()
    }
    
    @State var offset: CGPoint = .zero
    @State var scale: CGFloat = 0
    
    @State var scalePosition: CGPoint = .zero
    
    @SceneStorage("isZooming") var isZooming: Bool = false
    
    var body: some View {
        
        content
            .offset(x: offset.x, y: offset.y)
            .overlay(
                GeometryReader { proxy in
                    
                    let size = proxy.size
                    
                    ZoomGesture(size: size, scale: $scale, offset: $offset, scalePosition: $scalePosition)
                    
                })
            .scaleEffect(1 + (scale < 0 ? 0 : scale), anchor: .init(x: scalePosition.x, y: scalePosition.y))
            .zIndex(scale != 0 ? 1000 : 0)
            .onChange(of: scale) { newValue in
                
                isZooming = (scale != 0 && offset != .zero)
                
                if scale == -1{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        scale = 0
                    }
                }
            }
    }
}

struct ZoomGesture: UIViewRepresentable {
    
    var size: CGSize
    
    @Binding var scale: CGFloat
    @Binding var offset: CGPoint
    
    @Binding var scalePosition: CGPoint
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIView {
        
        let view = UIView()
        view.backgroundColor = .clear
        
        let Pinchgesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePinch(sender:)))
        
        view.addGestureRecognizer(Pinchgesture)
        
        let Pangesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePan(sender:)))
        
        Pangesture.delegate = context.coordinator
        
        view.addGestureRecognizer(Pinchgesture)
        view.addGestureRecognizer(Pangesture)

        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    class Coordinator: NSObject,UIGestureRecognizerDelegate {
        
        var parent: ZoomGesture
        
        init(parent: ZoomGesture) {
            self.parent = parent
        }
        
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
        
        @objc
        func handlePan(sender: UIPanGestureRecognizer) {
            
            sender.maximumNumberOfTouches = 2
            
            if (sender.state == .began || sender.state == .changed) && parent.scale > 0 {
                
                if let view = sender.view {
                    
                    let translation = sender.translation(in: view)
                    
                    parent.offset = translation
                }
            }
            else {
                withAnimation{
                    parent.offset = .zero
                    parent.scalePosition = .zero
                }
            }
        }
        @objc
        func handlePinch(sender: UIPinchGestureRecognizer) {
            
            if sender.state == .began || sender.state == .changed {
                
                parent.scale = (sender.scale - 1)
                
                let scalePoint = CGPoint(x: sender.location(in: sender.view).x / sender.view!.frame.size.width, y: sender.location(in: sender.view).y / sender.view!.frame.size.height)
                
                parent.scalePosition = (parent.scalePosition == .zero ? scalePoint: parent.scalePosition)
            }
            else {
                withAnimation(.easeInOut(duration: 0.35)){
                    parent.scale = -1
                    parent.scalePosition = .zero
                }
            }
        }
    }
}

extension View {
    func getRect()->CGRect {
        return UIScreen.main.bounds
    }
}
