//
//  ViewController.swift
//  iOS10-HW12-Anton Isakov
//
//  Created by Антон Исаков on 19.06.2023.
//

import UIKit

class ViewController: UIViewController {

    private var timer = Timer()
    private var isWorkTime = true
    private var isStarted = true
    private let workTimeDuration = 25.0
    private let restTimeDuration = 5.0
    private lazy var currentTime = workTimeDuration
   
    private lazy var timerLabel: UILabel = {
        let timerLabel = UILabel()
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.textAlignment = .center
        timerLabel.text = "00:\(Int(workTimeDuration))"
        timerLabel.textColor = UIColor.systemGreen
        timerLabel.font = UIFont.systemFont(ofSize: 64)
        return timerLabel
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.systemGreen
        let playSymbol = UIImage(systemName: "play", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32))
        button.setImage(playSymbol, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var progressBarLabel: CircularProgressBarView = {
        let progressBarLabel = CircularProgressBarView()
        progressBarLabel.translatesAutoresizingMaskIntoConstraints = false
        return progressBarLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Private functions

    private func setupView() {
        view.backgroundColor = .black
    }

    private func setupHierarchy() {
        view.addSubview(timerLabel)
        view.addSubview(button)
        view.addSubview(progressBarLabel)
    }

    private func setupLayout() {
        let height = view.bounds.height // 812
        let width = view.bounds.width // 375

        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint (equalTo: view.centerYAnchor),

            button.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: height * 0.04),
            button.leftAnchor.constraint (equalTo: view.leftAnchor, constant: width * 0.13),
            button.rightAnchor.constraint (equalTo: view.rightAnchor, constant: -width * 0.13)
            
        ])
        progressBarLabel.center = view.center
        progressBarLabel.createCircularPath()
        // call the animation with circularViewDuration
        
        // add this view to the view controller
    }
    
    private func changeLabel() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss"
        let timeInterval = TimeInterval(floatLiteral: currentTime)
        let date = Date(timeIntervalSince1970: timeInterval)
        let formattedString = formatter.string(from: date)
        
        timerLabel.text = formattedString
    }

    // MARK: - Actions

    @objc func startButtonTapped() {
        
        guard isStarted else {
            button.setImage(UIImage(systemName: "play", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32)), for: .normal)
            timer.invalidate()
            progressBarLabel.progressAnimation(duration: currentTime)
            isStarted.toggle()
            return
        }
        button.setImage(UIImage(systemName: "pause", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32)), for: .normal)
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        progressBarLabel.progressAnimation(duration: currentTime)
        isStarted.toggle()
    }
    
    
    @objc func timerAction() {
        
        changeLabel()
        
        if currentTime <= 0 {
            
            if isWorkTime {
                currentTime = restTimeDuration
                timerLabel.textColor = UIColor.systemRed
                button.tintColor = UIColor.systemRed
            } else {
                currentTime = workTimeDuration
                timerLabel.textColor = UIColor.systemGreen
                button.tintColor = UIColor.systemGreen
            }
            isWorkTime.toggle()
        }
        currentTime -= 0.01
    }
    
    // MARK: - Properties -
        
//        var circularProgressBarView: CircularProgressBarView!
//var circularViewDuration: TimeInterval = 2
//
//    func setUpCircularProgressBarView() {
//            // set view
//            circularProgressBarView = CircularProgressBarView(frame: .zero)
//            // align to the center of the screen
//            circularProgressBarView.center = view.center
//            // call the animation with circularViewDuration
//            circularProgressBarView.progressAnimation(duration: circularViewDuration)
//            // add this view to the view controller
            
       // }
}
// ProgressBar

class CircularProgressBarView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Properties -
    
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var startPoint = CGFloat(-Double.pi / 2)
    private var endPoint = CGFloat(3 * Double.pi / 2)
    
    func createCircularPath() {
            // created circularPath for circleLayer and progressLayer
            let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: 140, startAngle: startPoint, endAngle: endPoint, clockwise: true)
            // circleLayer path defined to circularPath
            circleLayer.path = circularPath.cgPath
            // ui edits
            circleLayer.fillColor = UIColor.clear.cgColor
            circleLayer.lineCap = .round
            circleLayer.lineWidth = 20.0
            circleLayer.strokeEnd = 1.0
            circleLayer.strokeColor = UIColor.white.cgColor
            // added circleLayer to layer
            layer.addSublayer(circleLayer)
            // progressLayer path defined to circularPath
            progressLayer.path = circularPath.cgPath
            // ui edits
            progressLayer.fillColor = UIColor.clear.cgColor
            progressLayer.lineCap = .round
            progressLayer.lineWidth = 10.0
            progressLayer.strokeEnd = 0
            progressLayer.strokeColor = UIColor.green.cgColor
            // added progressLayer to layer
            layer.addSublayer(progressLayer)
        }
    
    func progressAnimation(duration: TimeInterval) {
            // created circularProgressAnimation with keyPath
            let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
            // set the end time
            circularProgressAnimation.duration = duration
            circularProgressAnimation.toValue = 1.0
            circularProgressAnimation.fillMode = .forwards
            circularProgressAnimation.isRemovedOnCompletion = false
            progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
        }
}

