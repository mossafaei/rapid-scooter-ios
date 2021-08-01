//
//  BarcodeReaderViewController.swift
//  Rapid
//
//  Created by Apple on 11/26/19.
//  Copyright © 2019 ___MostafaSafaeipour___. All rights reserved.
//

import UIKit
import AVFoundation
class BarcodeReaderViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession = AVCaptureSession()
    var captureDevice:AVCaptureDevice?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var responseFromQrCode:String!
    var mainView:MainViewController?
    
    @IBAction func TurnOnFlashLight(_ sender: Any) {
        if (captureDevice!.hasTorch){
            do{
                try captureDevice!.lockForConfiguration()
                if (captureDevice!.torchMode == .on){
                    captureDevice!.torchMode = .off
                }else{
                    captureDevice!.torchMode = .on
                }
                captureDevice!.unlockForConfiguration()
            }catch{
                print("cannot use")
                return
            }
        }else{
            print("Device has not flashlight")
        }
    }
    @IBAction func BackToMain(_ sender: Any) {
        captureSession.stopRunning()
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let cpD = AVCaptureDevice.default(for: .video){
            captureDevice = cpD
        }else{
            print("cannot find")
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            captureSession.addInput(input)
            
            let captureMetaDataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetaDataOutput)
            captureMetaDataOutput.metadataObjectTypes = [.qr]
            captureMetaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
        } catch {
            print(error)
            return
        }
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.frame = view.layer.bounds
        videoPreviewLayer?.videoGravity = .resizeAspectFill
        videoPreviewLayer?.opacity = 0.3
        
        view.layer.insertSublayer(videoPreviewLayer!, at: 0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        captureSession.startRunning()
    }
    
    private func updatePreviewLayer(layer: AVCaptureConnection, orientation: AVCaptureVideoOrientation) {
        layer.videoOrientation = orientation
        videoPreviewLayer?.frame = self.view.bounds
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let connection =  self.videoPreviewLayer?.connection  {
            let currentDevice: UIDevice = UIDevice.current
            let orientation: UIDeviceOrientation = currentDevice.orientation
            let previewLayerConnection : AVCaptureConnection = connection
            
            if previewLayerConnection.isVideoOrientationSupported {
                switch (orientation) {
                case .portrait:
                    updatePreviewLayer(layer: previewLayerConnection, orientation: .portrait)
                    break
                case .landscapeRight:
                    updatePreviewLayer(layer: previewLayerConnection, orientation: .landscapeLeft)
                    break
                case .landscapeLeft:
                    updatePreviewLayer(layer: previewLayerConnection, orientation: .landscapeRight)
                    break
                case .portraitUpsideDown:
                    updatePreviewLayer(layer: previewLayerConnection, orientation: .portraitUpsideDown)
                    break
                default:
                    updatePreviewLayer(layer: previewLayerConnection, orientation: .portrait)
                    break
                }
            }
        }
    }
    
    func isQrCodeValid()->Bool{
        if (responseFromQrCode.count == 5 && responseFromQrCode.hasPrefix("A")){
            return true
        }
        return false
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if (metadataObjects.count == 0){
            return
        }
        let metaObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        responseFromQrCode = metaObj.stringValue!
        if (metaObj.stringValue != nil){
            responseFromQrCode = metaObj.stringValue!
            let generator = UINotificationFeedbackGenerator()
            if (isQrCodeValid()){
                self.dismiss(animated: true, completion: {
                    generator.notificationOccurred(.success)
                   self.mainView?.showScooterView(responseString: self.responseFromQrCode)
                })
            }
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
