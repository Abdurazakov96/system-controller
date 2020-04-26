//
//  ViewController.swift
//  system controller
//
//  Created by Магомед Абдуразаков on 17/08/2019.
//  Copyright © 2019 Магомед Абдуразаков. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

class ViewController: UIViewController {
    
    // MARK: - IBOtlets
    
    @IBOutlet var stack: UIStackView!
    @IBOutlet var image: UIImageView!
    
    // MARK: - Lifecycle
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if size.width > size.height {
            stack.axis = .horizontal
        }
        else { stack.axis = .vertical}
    }
    
    // MARK: - IBActions
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        guard let image = image.image else {return}
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityController, animated: true)
    }
    
    @IBAction func safariButtonPressed(_ sender: UIButton) {
        let url = URL(string: "http://apple.com")!
        let safari = SFSafariViewController(url: url)
        present(safari, animated: true)
    }
    
    
    @IBAction func cameraButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Please choose image source", message: nil, preferredStyle: .actionSheet)
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let camera = UIAlertAction(title: "Camera", style: .default) {action in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true)
            }
            alert.addAction(camera)
        }
        
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibrary = UIAlertAction(title: "PhotoLibrary", style: .default) { action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true)
            }
            alert.addAction(photoLibrary)
        }
        present(alert, animated: true)
    }
    
    @IBAction func emailButtonPressed(_ sender: UIButton) {
        guard MFMailComposeViewController.canSendMail() else {
            print("dsd")
            return}
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        
        mailComposer.setCcRecipients(["abdurazakov96@mail.ru"])
        mailComposer.setSubject("Ошибка \(Date())")
        mailComposer.setMessageBody("Пожалуйста, помогите с  Message Composerom", isHTML: false)
        //present(mailComposer, animated: true)
        guard let filePath = Bundle.main.path(forResource: "Image", ofType: "jpg") else {
            print("нет файла")
            return
            
        }
        
        print("есть файл")
        let url = URL(fileURLWithPath: filePath)
        
        do {
            let attachmentData = try! Data(contentsOf: url)
            mailComposer.addAttachmentData(attachmentData, mimeType: "application/jpg", fileName: "Tiger")
            mailComposer.mailComposeDelegate = self
            
            present(mailComposer, animated: true)
        }
        
    }
    
    @IBAction func smsButtonPressed(_ sender: UIButton) {
        
        guard MFMessageComposeViewController.canSendText() else {print("dsa")
            return}
        
        
        let messageComposeViewController = MFMessageComposeViewController()
        messageComposeViewController.messageComposeDelegate = self
        messageComposeViewController.body = "Отправка сообщения"
        // present(messageComposeViewController, animated: true, completion: nil)
        guard let filePath = Bundle.main.path(forResource: "Image", ofType: "jpg") else {
            print("нет файла")
            return
            
        }
        
        print("есть файл")
        let url = URL(fileURLWithPath: filePath)
        
        do {
            let attachmentData = try! Data(contentsOf: url)
            messageComposeViewController.addAttachmentData(attachmentData, typeIdentifier: "application/jpg", filename: "Tiger")
            messageComposeViewController.messageComposeDelegate = self
            
            present(messageComposeViewController, animated: true)
        }
        
    }
    
}

// MARK: - Extension

extension ViewController: UIImagePickerControllerDelegate {
    
    // MARK: - Public methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else { return  }
        
        image.image = selectedImage
        dismiss(animated: true)
    }
    
}

// MARK: - Extension

extension ViewController: UINavigationControllerDelegate{
    
}

// MARK: - Extension

extension ViewController: MFMailComposeViewControllerDelegate{
    
    // MARK: - Public methods
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        dismiss(animated: true)
    }
    
}

// MARK: - Extension

extension ViewController: MFMessageComposeViewControllerDelegate{
    
    // MARK: - Public methods
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        dismiss(animated: true, completion: nil)
    }
    
}



