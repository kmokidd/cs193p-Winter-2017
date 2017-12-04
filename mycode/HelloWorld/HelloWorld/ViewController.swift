//
//  ViewController.swift
//  HelloWorld
//
//  Created by kiddhe on 2017/11/1.
//  Copyright © 2017年 kiddhe. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation

class ViewController: UIViewController {
  
  //  程序内变量
  var scrollVar = 0;
  var targetValue = 0;
  var roundValue = 0;
  var scoreValue: Float = 0.0;
  
  var audioPlayer: AVAudioPlayer!
  
  //  UI 变量，将和程序内变量联动
  @IBOutlet weak var slider:UISlider!
  @IBOutlet weak var round: UILabel!
  @IBOutlet weak var target: UILabel!
  @IBOutlet weak var score: UILabel!
  
  
  
  func startNewRound() {
    updateTarget();
    
    // 每次开始一轮游戏时，游标回到中间
    scrollVar = 50;
    slider.value = Float(scrollVar);
    
    // 更新游戏轮次
    roundValue += 1;
    round.text = String(roundValue);
  }
  
  func updateTarget(){
    targetValue = 1 + Int(arc4random_uniform(100));
    target.text = String(targetValue);
    
    score.text = String(scoreValue);
  }
  
//  重置全部变量
  func resetGame() {
    scoreValue = 0.0;
    roundValue = 0;
    
    startNewRound();
    
    let transition = CATransition()
    transition.type = kCATransitionFade
    transition.duration = 1
    transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    
    view.layer.add(transition, forKey: nil)
    
  }
  
  func playBgMusic() {
    let musicPath = Bundle.main.path(forResource: "bgmusic", ofType: "mp3");
    let url = URL.init(fileURLWithPath: musicPath!);
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: url)
    }catch _ {
      audioPlayer = nil
    }
    
    audioPlayer.numberOfLoops = -1
    audioPlayer.prepareToPlay()
    audioPlayer.play()
  }
  
  override func viewDidLoad() {
    playBgMusic()
    super.viewDidLoad()
    
    // Do any additional setup after loading the view, typically from a nib.
    resetGame();
    
    let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
    slider.setThumbImage(thumbImageNormal, for: .normal);
    
    let thumbImageHl = UIImage(named: "SliderThumb-Hl")!
    slider.setThumbImage(thumbImageHl, for: .highlighted);
    
    let insets = UIEdgeInsets(top:0, left:14, bottom:0, right:14);
    let trackLeftImage = UIImage(named: "SliderTrackLeft")!
    let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets);
    
    slider.setMinimumTrackImage(trackLeftResizable, for: .normal);
    
    let trackRightImage = UIImage(named: "SliderTrackRight")!
    let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets);
    
    slider.setMaximumTrackImage(trackRightResizable, for: .normal);
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
    

  // 弹出警告框
  @IBAction func showAlert(){
    
    // 本次得分
    let diff = Float(targetValue - abs(scrollVar - targetValue));
    var pts = ceil(diff/Float(targetValue)*100);
    let str: String;
    
    if(pts<60){
      str = "这个游戏不适合你";
    }
    else if(pts >= 60 && pts < 95) {
      str = "再努力一下"
    }else if(pts >= 95 && pts < 100){
      str = "非常接近了，bonus 24！";
      pts += 24;
    }else {
      str = "很棒的你，bonus 39!";
      pts += 39;
    }
    
    // 更新得分
    scoreValue += pts;
    
    let msg = "当前数值是 : \(scrollVar)\n 目标数值是：\(targetValue) \n 差值为：\(abs(scrollVar - targetValue))\n 本次得分为：\(pts)\n 评语：\(str)";
  
    let alert = UIAlertController(title: "TIPS",
                           message: msg,
                           preferredStyle: .alert)
    let action = UIAlertAction(title:"ok", style: .default, handler: {
      action in self.startNewRound()
    })
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
    
    
//    startNewRound();
  }
    

  // 滑块条事件
  @IBAction func sliderMoved(slider: UISlider) {
      scrollVar = lroundf(slider.value);
  }
  
  // 重置游戏
  @IBAction func reset(){
    resetGame();
  }

}

