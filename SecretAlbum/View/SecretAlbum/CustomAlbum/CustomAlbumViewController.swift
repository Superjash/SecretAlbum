//
//  SecretViewController.swift
//  SecretAlbum
//
//  Created by Jash on 2018/12/24.
//  Copyright © 2018 Jash. All rights reserved.
//

import UIKit

class CustomAlbumViewController: UIViewController {
    
    private var dataSource: [File] = []
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Custom"
        view.backgroundColor = .white
        
//        tableView = UITableView(frame: view.bounds, style: .grouped)
//        tableView.dataSource = self
//        tableView.delegate = self
//        view.addSubview(tableView)
        
        
//        let start = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
//        drawLineFromPoint(start: start, end: CGPoint(x: 0, y: start.y - 130), control: CGPoint(x: view.bounds.width / 2 * 0.5, y: start.y - 140), color: .red, view: view)
//        drawLineFromPoint(start: start, end: CGPoint(x: 0, y: start.y - 80), control: CGPoint(x: view.bounds.width / 2 * 0.6, y: start.y - 100), color: .red, view: view)
//        drawLineFromPoint(start: start, end: CGPoint(x: 0, y: start.y - 30), control: CGPoint(x: view.bounds.width / 2 * 0.5, y: start.y - 50), color: .red, view: view)
//        drawLineFromPoint(start: start, end: CGPoint(x: 0, y: start.y + 80), control: CGPoint(x: view.bounds.width / 2 * 0.8, y: start.y - 20), color: .red, view: view)
//        drawLineFromPoint(start: start, end: CGPoint(x: 0, y: start.y + 160), control: CGPoint(x: view.bounds.width / 2 * 0.9, y: start.y - 10), color: .red, view: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.title = "Documents"
    }
    
    private func loadFiles() {
//        DispatchQueue.main
//        let files: [String] = findFiles(path: NSHomeDirectory().appending("/Documents"), filterTypes: [])
//        for file in files {
//            dataSource.append(File(fullName: file))
//        }
    }
    
    private func drawLineFromPoint(start: CGPoint, end: CGPoint, control: CGPoint, color: UIColor, view: UIView) {
        //design the path
        let path = UIBezierPath()
        path.move(to: start)
        path.addQuadCurve(to: end, controlPoint: control)
        
        //design path in layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1.0
        
        view.layer.addSublayer(shapeLayer)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        
    }
}

//extension CustomAlbumViewController: UITableViewDataSource, UITableViewDelegate {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0 // CGFloat.leastNonzeroMagnitude
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dataSource.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: false)
//    }
//}
