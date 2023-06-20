//
//  ViewController.swift
//  iOS10-HW12-Anton Isakov
//
//  Created by Антон Исаков on 19.06.2023.
//

import UIKit

class ViewController: UIViewController {

    var timer = Timer()
   
    
    private lazy var timerLabel: UILabel = {
        let timerLabel = UILabel()
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.textAlignment = .center
        timerLabel.text = "00:25"
        timerLabel.textColor = UIColor.systemGreen
        timerLabel.font = UIFont.systemFont(ofSize: 64)
        return timerLabel
    }()

    private lazy var button: UIButton = {
        var isWorkTime:Bool
        var isStarted:Bool
        let button = UIButton(type: .system)
        button.tintColor = UIColor.systemGreen
        let pauseSymbol = UIImage(systemName: "pause", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32))
        button.setImage(pauseSymbol, for: .normal)
        let playSymbol = UIImage(systemName: "play", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32))
        button.setImage(playSymbol, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
        startButtonTapped()
    }

    // MARK: - Setups

    private func setupView() {
        view.backgroundColor = .black
    }

    private func setupHierarchy() {
        view.addSubview(timerLabel)
        view.addSubview(button)
    }

    private func setupLayout() {
        let height = view.bounds.height // 812
        let width = view.bounds.width // 375

        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint (equalTo: view.centerYAnchor),

            button.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: height * 0.06),
            button.leftAnchor.constraint (equalTo: view.leftAnchor, constant: width * 0.13),
            button.rightAnchor.constraint (equalTo: view.rightAnchor, constant: -width * 0.13)
        ])
    }

    // MARK: - Actions

    @objc func startButtonTapped() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction) , userInfo: nil, repeats: true)
//        button.isWorkTime = true
//        if button.isWorkTime == true {
//            button.setImage(playSymbol, for: .normal)
//        } else { button.setImage(pauseSymbol, for: .normal)}
        
    }

    @objc func changeLabel() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss"
        let date = Date(timeIntervalSince1970: 0)
        let formattedString = formatter.string(from: date)
        
        timerLabel.text = formattedString
        
        
    }
    
    
    @objc  func timerAction() {


    }
}

//
//
//
    
//import UIKit
//
//class ViewController: UIViewController {
//
//    let timerLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 48)
//        label.textAlignment = .center
//        return label
//    }()
//
//    let playPauseButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Play", for: .normal)
//        button.setTitleColor(.systemBlue, for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
//        button.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
//        return button
//    }()
//
//    let progressBar: CircularProgressView = {
//        let view = CircularProgressView()
//        view.trackColor = .systemGray
//        view.progressColor = .systemBlue
//        return view
//    }()
//
//    var isWorkTime = true
//    var isStarted = false
//
//    var timer: Timer?
//    var totalTime: TimeInterval = 25
//    var currentTime: TimeInterval = 0
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .white
//
//        view.addSubview(timerLabel)
//        view.addSubview(playPauseButton)
//        view.addSubview(progressBar)
//
//        timerLabel.translatesAutoresizingMaskIntoConstraints = false
//        timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        timerLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
//
//        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
//        playPauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        playPauseButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 20).isActive = true
//
//        progressBar.translatesAutoresizingMaskIntoConstraints = false
//        progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        progressBar.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        progressBar.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        progressBar.heightAnchor.constraint(equalToConstant: 200).isActive = true
//
//        updateUI()
//    }
//
//    func updateUI() {
//        let formattedTime = formatTime(currentTime)
//        timerLabel.text = formattedTime
//
//        let playPauseButtonTitle = isStarted ? (isWorkTime ? "Pause" : "Play") : "Play"
//        playPauseButton.setTitle(playPauseButtonTitle, for: .normal)
//
//        let progress = CGFloat(currentTime / totalTime)
//        progressBar.setProgress(progress)
//
//        let progressBarColor = isWorkTime ? UIColor.red : UIColor.green
//        progressBar.setProgressColor(progressBarColor)
//    }
//
//    @objc func playPauseButtonTapped() {
//        isStarted = !isStarted
//
//        if isStarted {
//            startTimer()
//        } else {
//            stopTimer()
//        }
//
//        updateUI()
//    }
//
//    func startTimer() {
//        if timer == nil {
//            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
//        }
//    }
//
//    func stopTimer() {
//        timer?.invalidate()
//        timer = nil
//    }
//
//    @objc func updateTimer() {
//        currentTime += 1
//
//        if currentTime >= totalTime {
//            isWorkTime.toggle()
//            currentTime = 0
//        }
//
//        updateUI()
//    }
//
//    func formatTime(_ time: TimeInterval) -> String {
//        let minutes = Int(time) / 60
//        let seconds = Int(time) % 60
//        return String(format: "%02d:%02d", minutes, seconds)
//    }
//}
//
//class CircularProgressView: UIView {
//    var trackColor: UIColor = .lightGray
//    var progressColor: UIColor = .blue
//    private var progressLayer = CAShapeLayer()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        configureProgressLayer()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        configureProgressLayer()
//    }
//
//    private func configureProgressLayer() {
//        let center = CGPoint(x: bounds.midX, y: bounds.midY)
//        let radius = min(bounds.width, bounds.height) / 2
//
//        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
//
//        progressLayer.path = circularPath.cgPath
//        progressLayer.strokeColor = progressColor.cgColor
//        progressLayer.lineWidth = 10
//        progressLayer.fillColor = UIColor.clear.cgColor
//        progressLayer.lineCap = .round
//        progressLayer.strokeEnd = 0
//
//        layer.addSublayer(progressLayer)
//
//        let trackLayer = CAShapeLayer()
//        trackLayer.path = circularPath.cgPath
//        trackLayer.strokeColor = trackColor.cgColor
//        trackLayer.lineWidth = 10
//        trackLayer.fillColor = UIColor.clear.cgColor
//
//        layer.addSublayer(trackLayer)
//    }
//
//    func setProgress(_ progress: CGFloat) {
//        progressLayer.strokeEnd = progress
//    }
//
//    func setProgressColor(_ color: UIColor) {
//        progressLayer.strokeColor = color.cgColor
//    }
//}
//
//
