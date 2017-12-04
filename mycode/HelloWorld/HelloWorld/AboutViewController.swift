//
//  AboutViewController.swift
//  HelloWorld
//
//  Created by kiddhe on 2017/11/10.
//  Copyright © 2017年 kiddhe. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
  @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
/*      本地 html 文件的显示方式
      if let url = Bundle.main.url(forResource: "move", withExtension: "html"){
        if let htmlData = try? Data(contentsOf: url){
          let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
          webView.load(htmlData, mimeType: "text/html",
                       textEncodingName: "UTF-8",
                       baseURL: baseURL)
        }
      }
 */
      let myURL = URL.init(string: "https://www.baidu.com/")
      let request: URLRequest = URLRequest(url: myURL!)
      webView.loadRequest(request);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  @IBAction func close() {
    dismiss(animated: true, completion: nil)
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
