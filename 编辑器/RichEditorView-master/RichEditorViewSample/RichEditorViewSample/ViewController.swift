//
//  ViewController.swift
//  RichEditorViewSample
//
//  Created by Caesar Wirth on 4/5/15.
//  Copyright (c) 2015 Caesar Wirth. All rights reserved.
//

import UIKit
import RichEditorView
import Foundation
class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet var editorView: RichEditorView!
    @IBOutlet var htmlTextView: UITextView!

    lazy var toolbar: RichEditorToolbar = {
        let toolbar = RichEditorToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        toolbar.options = RichEditorDefaultOption.all
        return toolbar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        editorView.delegate = self
        editorView.inputAccessoryView = toolbar

        toolbar.delegate = self
        toolbar.editor = editorView

        // We will create a custom action that clears all the input text when it is pressed
        let item = RichEditorOptionItem(image: nil, title: "Clear") { toolbar in
            toolbar.editor?.html = ""
        }
        let path = Bundle.main.path(forResource: "test", ofType: "html")
        let url = URL.init(fileURLWithPath: path!)
        let detail = try!Data.init(contentsOf: url)
        let htmlStr = String.init(data: detail, encoding: String.Encoding.utf8)
        print(htmlStr!)
        toolbar.editor?.html = htmlStr!
        var options = toolbar.options
        options.append(item)
        toolbar.options = options
    }
    //相册方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        print("选择图片")
        picker.dismiss(animated: true, completion: { () -> Void in
            self.toolbar.editor?.insertImage("https://gravatar.com/avatar/696cf5da599733261059de06c4d1fe22", alt: "Gravatar")
        })
    }
}

extension ViewController: RichEditorDelegate {

    func richEditor(_ editor: RichEditorView, contentDidChange content: String) {
        
        if content.isEmpty {
            htmlTextView.text = "HTML Preview"
        } else {
            htmlTextView.text = content
        }
    }
    
}

extension ViewController: RichEditorToolbarDelegate {

    fileprivate func randomColor() -> UIColor {
        let colors: [UIColor] = [
            .red,
            .orange,
            .yellow,
            .green,
            .blue,
            .purple
        ]
        
        let color = colors[Int(arc4random_uniform(UInt32(colors.count)))]
        return color
    }

    func richEditorToolbarChangeTextColor(_ toolbar: RichEditorToolbar) {
        let color = randomColor()
        toolbar.editor?.setTextColor(color)
    }

    func richEditorToolbarChangeBackgroundColor(_ toolbar: RichEditorToolbar) {
        let color = randomColor()
        toolbar.editor?.setTextBackgroundColor(color)
    }

    func richEditorToolbarInsertImage(_ toolbar: RichEditorToolbar) {
        openAlbum()
//        toolbar.editor?.insertImage("https://gravatar.com/avatar/696cf5da599733261059de06c4d1fe22", alt: "Gravatar")
    }
    
    //打开相册
    
    func openAlbum(){
        let picker:UIImagePickerController = UIImagePickerController()
        picker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            self.present(picker, animated: true, completion: { () -> Void in
                
            })
        }else{
            print("为授予防问相机权限")
        }
        
    }
    

    func richEditorToolbarInsertLink(_ toolbar: RichEditorToolbar) {
        // Can only add links to selected text, so make sure there is a range selection first
        if toolbar.editor?.hasRangeSelection == true {
            toolbar.editor?.insertLink("http://github.com/cjwirth/RichEditorView", title: "Github Link")
        }
    }
}
