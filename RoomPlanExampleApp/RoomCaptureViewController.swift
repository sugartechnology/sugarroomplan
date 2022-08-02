/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The sample app's main view controller that manages the scanning process.
*/

import UIKit
import RoomPlan

class RoomCaptureViewController: UIViewController, RoomCaptureViewDelegate, RoomCaptureSessionDelegate {
    
    @IBOutlet weak var popupBrands: ViewStyle!
    @IBOutlet var exportButton: UIButton?
    
    @IBOutlet var doneButton: UIBarButtonItem?
    @IBOutlet var cancelButton: UIBarButtonItem?
    
    private var isScanning: Bool = false
    
    private var roomCaptureView: RoomCaptureView!
    private var roomCaptureSessionConfig: RoomCaptureSession.Configuration = RoomCaptureSession.Configuration()
    
    private var finalResults: CapturedRoom?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up after loading the view.
        setupRoomCaptureView()
        popupBrands.isHidden = true;
    }
    
    private func setupRoomCaptureView() {
        roomCaptureView = RoomCaptureView(frame: view.bounds)
        roomCaptureView.captureSession.delegate = self
        roomCaptureView.delegate = self
        
        view.insertSubview(roomCaptureView, at: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startSession()
    }
    
    override func viewWillDisappear(_ flag: Bool) {
        super.viewWillDisappear(flag)
        stopSession()
    }
    
    private func startSession() {
        isScanning = true
        roomCaptureView?.captureSession.run(configuration: roomCaptureSessionConfig)
        
        setActiveNavBar()
    }
    
    private func stopSession() {
        isScanning = false
        roomCaptureView?.captureSession.stop()
        
        setCompleteNavBar()
    }
    
    // Decide to post-process and show the final results.
    func captureView(shouldPresent roomDataForProcessing: CapturedRoomData, error: Error?) -> Bool {
        return true
    }
    
    // Access the final post-processed results.
    func captureView(didPresent processedResult: CapturedRoom, error: Error?) {
        finalResults = processedResult
    }
    
    @IBAction func doneScanning(_ sender: UIBarButtonItem) {
        if isScanning { stopSession() } else { cancelScanning(sender) }
    }

    @IBAction func cancelScanning(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
    }
    
    @IBAction func exportResults(_ sender: UIButton) {
        let destinationURL = FileManager.default.temporaryDirectory.appending(path: "Room.usdz")
        do {
            try finalResults?.export(to: destinationURL)
            
            let activityVC = UIActivityViewController(activityItems: [destinationURL], applicationActivities:
                                                        [CustomActivity(title:"İstikbale Gönder", imagePath: "istikbal"),
                                                         CustomActivity(title:"Bellonaya Gönder", imagePath: "bellona_logo")])
            activityVC.modalPresentationStyle = .popover
            
            present(activityVC, animated: true, completion: nil)
            
            if let popOver = activityVC.popoverPresentationController {
                popOver.sourceView = self.exportButton
            }
            
            //self.popupBrands.isHidden = false
            self.popupBrands.transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],  animations: {
                    //use if you want to darken the background
                    //self.viewDim.alpha = 0.8
                    //go back to original form
                self.popupBrands.transform = .identity
            })

        } catch {
            print("Error = \(error)")
        }
    }
    
    private func setActiveNavBar() {
        UIView.animate(withDuration: 1.0, animations: {
            self.cancelButton?.tintColor = .white
            self.doneButton?.tintColor = .white
            self.exportButton?.alpha = 0.0
        }, completion: { complete in
            self.exportButton?.isHidden = true
            self.popupBrands.isHidden = true
        })
    }
    
    private func setCompleteNavBar() {
        self.exportButton?.isHidden = false
        UIView.animate(withDuration: 1.0) {
            self.cancelButton?.tintColor = .systemBlue
            self.doneButton?.tintColor = .systemBlue
            self.doneButton?.title = "Done"
            self.exportButton?.alpha = 1.0
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        self.popupBrands.isHidden = true
    }
}

