//
//  SplashViewController.swift
//  StockReport
//
//  Created by Doyoung Song on 12/8/22.
//

import Lottie
import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var lottieAnimationView: LottieAnimationView!
    @IBOutlet weak var companyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateLottie()
        animateLabel()
    }
}

extension SplashViewController {
    
    private func setupUI() {
        lottieAnimationView.contentMode = .scaleAspectFit
    }
    
    private func animateLottie() {
        lottieAnimationView.play(completion: { [weak self] _ in
            self?.performSegue(withIdentifier: String(describing: ReportViewController.self), sender: self)
        })
    }
    
    private func animateLabel() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6,
                                      execute: {
            UIView.animate(withDuration: 0.4,
                           delay: 0,
                           animations: { [weak self] in
                self?.companyLabel.alpha = 1
            })
        })
    }
}
