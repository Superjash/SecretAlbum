//
//  SecretViewController.swift
//  SecretAlbum
//
//  Created by Jash on 2018/12/24.
//  Copyright © 2018 Jash. All rights reserved.
//

import UIKit

class CustomAlbumViewController: UIViewController {
    
    private var tableView: UITableView!
//    private var

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .black
        
        tableView = UITableView(frame: view.bounds, style: .grouped)
        
        let arr = findFiles(path: NSHomeDirectory().appending("/Documents"), filterTypes: [])
        
        let start = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
        drawLineFromPoint(start: start, end: CGPoint(x: 0, y: start.y - 130), control: CGPoint(x: view.bounds.width / 2 * 0.5, y: start.y - 140), color: .red, view: view)
        drawLineFromPoint(start: start, end: CGPoint(x: 0, y: start.y - 80), control: CGPoint(x: view.bounds.width / 2 * 0.6, y: start.y - 100), color: .red, view: view)
        drawLineFromPoint(start: start, end: CGPoint(x: 0, y: start.y - 30), control: CGPoint(x: view.bounds.width / 2 * 0.5, y: start.y - 50), color: .red, view: view)
        drawLineFromPoint(start: start, end: CGPoint(x: 0, y: start.y + 80), control: CGPoint(x: view.bounds.width / 2 * 0.8, y: start.y - 20), color: .red, view: view)
        drawLineFromPoint(start: start, end: CGPoint(x: 0, y: start.y + 160), control: CGPoint(x: view.bounds.width / 2 * 0.9, y: start.y - 10), color: .red, view: view)

        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.backgroundColor = .cyan
        button.frame = CGRect(x: (view.bounds.width - 80) / 2, y: (view.bounds.height - 80) / 2, width: 80, height: 80)
        button.layer.cornerRadius = 40
        button.clipsToBounds = true
//        view.addSubview(button)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.title = "Documents"
    }
    
    private func findFiles(path: String, filterTypes: [String]) -> [String] {
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: path)
            if filterTypes.count == 0 {
                return files
            } else {
                let filteredfiles = NSArray(array: files).pathsMatchingExtensions(filterTypes)
                return filteredfiles
            }
        } catch {
            return []
        }
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
