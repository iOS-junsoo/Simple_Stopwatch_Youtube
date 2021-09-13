//
//  ViewController.swift
//  Simple_Timer_Youtube
//
//  Created by 준수김 on 2021/09/13.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startStopButton.setTitleColor(UIColor.green, for: .normal)
        //앱을 실행하면 startStopButton의 색을 초록색으로 한다.
    }
    @IBAction func resetTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "타이머 재설정", message: "타이머를 재설정 하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { (_) in //재설정 취소버튼
        //do nothing
        }))
        alert.addAction(UIAlertAction(title: "재설정", style: .default, handler: { (_) in //재설정 수락버튼 default: 기본값
            self.count = 0 //상승하는 count를 다시 0으로 설정
            self.timer.invalidate() //타이머를 중지하는 timer.invalidate()호출 invalidate: 무효화, 타이머가 다시 실행되는 것을 중지하고 런 루프에서 제거를 요청
            self.TimerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.startStopButton.setTitle("START", for: .normal)
            self.startStopButton.setTitleColor(UIColor.green, for: .normal)
        }))
        
        self.present(alert, animated: true, completion: nil)
        //alert 현재 뷰 컨트롤러의 콘텐츠 위에 표시할 것
        //animated: true : 애니메이션 ㄲ
        //completion: nil : 프레젠테이션이 완료된 후 실행할 블럭은 없다(nil).
    }
    @IBAction func startStopTapped(_ sender: UIButton) {
        if(timerCounting) //타이머가 시간을 계산중이라면
                {
                    timerCounting = false //timerCounting은 false
                    timer.invalidate() //사용자가 startStop버튼을 탭하면 타이머를 중지하는 timer.invalidate()호출
                    startStopButton.setTitle("START", for: .normal) //타이머가 시간을 계산중이라면 startStopButton의 타이틀은 START
                    startStopButton.setTitleColor(UIColor.green, for: .normal) //타이머가 시간을 계산중이라면 startStopButton의 색을 초록색
                }
                else //타이머가 시간을 계산중이 아니라면
                {
                    timerCounting = true //timerCounting은 true
                    startStopButton.setTitle("STOP", for: .normal) ////타이머가 시간을 계산중이 아니라면 startStopButton의 타이틀은 STOP
                    startStopButton.setTitleColor(UIColor.red, for: .normal) //타이머가 시간을 계산중이 아니 라면 startStopButton의 색을 빨간색
                    timer = Timer.scheduledTimer(timeInterval: 0.0157, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
                    //scheduledTimer: 타이머를 만들고 기본모드의 현재 실행 루프에서 타이머를 예약합니다.
                    //timeInterval:타이머 실행 간격 - 1 / target: 함수 selector가 호출되어야 하는 클래스 인스턴스 - 자신 / selector:  타이머가 실행될 때 호출 할 함수, / userInfo : selector 에게 제공되는 데이터가 있는 dictionary / repeats : 참일 경우 타이머는 무효화될 때까지 반복적으로 다시 예약, 거짓일 경우 타이머가 실행된 후 타이머가 무효화
                }
    }
    @objc func timerCounter() -> Void
        {
            count = count + 1 //이 함수가 호출될 때마다 count + 1
            let time = secondsToHoursMinutesSeconds(seconds: count) //증가하는 count 값을 secondsToHoursMinutesSeconds함수에 넣고 출력값을 time에 저장
            let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2) //makeTimeString함수에 time의 첫번째 값을 hours, 두번째 값을 minutes, 세번째 값을 seconds에 넣는다.
            TimerLabel.text = timeString //위에서 선언한 TimerLabel의 text 값에 timerString을 넣어준다.
        }
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) //초에서 시간 : 분 : 초로 바꾸어주는 함수
        {
            return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60)) //다음과 같은 연산으로 초를 이용해서 시간, 분, 초를 출력
        }
        
        func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String //위에서 만든 시간, 분, 초를 문자열 형태의 디티절 시간으로 출력
        {
            var timeString = ""
            timeString += String(format: "%02d", hours)
            timeString += " : "
            timeString += String(format: "%02d", minutes)
            timeString += " . "
            timeString += String(format: "%02d", seconds)
            return timeString //timeString의 형태 ->hours : minutes : seconds
        }
}

