//
//  ViewController.swift
//  FarklePad
//
//  Created by Scott Johnson on 11/2/14.
//  Copyright (c) 2014 Out of Range Productions. All rights reserved.
//

import UIKit
import StoreKit

class IAPViewController: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {

    let product_value =  ["farklepadfull","photobackgrounds"]
    var fullproduct: SKProduct!
    var photoproduct: SKProduct!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
        self.fetchAvailableProducts()
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    func fetchAvailableProducts() {
        let productID:NSSet = NSSet(objects: "farklepadfull","photobackgrounds")
        let productsRequest:SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>);
        productsRequest.delegate = self;
        productsRequest.start();
    }
    
    func productsRequest (request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        let products = response.products
        if products.count != 0
        {
            fullproduct = products[0] as SKProduct
            photoproduct = products[1] as SKProduct
            print("Fetched: " + fullproduct.productIdentifier)
            print("Fetched: " + photoproduct.productIdentifier)
        }
    }
    
    func canMakePurchases() -> Bool
    {
        return SKPaymentQueue.canMakePayments()
    }
    
    func purchaseMyProduct(product: SKProduct) {
        if (self.canMakePurchases()) {
            print("Purchases are allowed ...")
            let payment: SKPayment = SKPayment(product: product)
            SKPaymentQueue.defaultQueue().addPayment(payment)
        } else {
            print("Purchases are disabled in your device")
        }
    }
    override func viewWillDisappear(animated: Bool) {
        SKPaymentQueue.defaultQueue().removeTransactionObserver(self)
    }
    
    @IBAction func button1_Click(sender: AnyObject) {
        if (fullproduct == nil) {
            return
        }
     purchaseMyProduct(fullproduct)
    }
    func paymentQueue(queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction])    {
        for transaction:AnyObject in transactions {
            if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction{
                switch trans.transactionState {
                case .Purchased:
                    
                    print("purchased")
                    let prodID = trans.payment.productIdentifier
                    
                    if (prodID == "farklepadfull") {
                        print("full version!")
                        let prefs = NSUserDefaults.standardUserDefaults()
                        prefs.setValue(true, forKey: "fullversion")
                    } else if (prodID == "photobackgrounds") {
                        let prefs = NSUserDefaults.standardUserDefaults()
                        prefs.setValue(true, forKey: "photos")
                        
                    }
                    SKPaymentQueue.defaultQueue().finishTransaction(transaction as! SKPaymentTransaction)
                    break;
                case .Failed:
                    let alert = UIAlertView(title: "", message: "Purchase was not successfully completed.", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    SKPaymentQueue.defaultQueue().finishTransaction(transaction as! SKPaymentTransaction)
                    break;
                case .Restored:
                    SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
                    let alert = UIAlertView(title: "", message: "Successfully restored previous purchases.", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    let prodID = trans.payment.productIdentifier
                    if (prodID == "farlkepadfull") {
                        let prefs = NSUserDefaults.standardUserDefaults()
                        prefs.setValue(true, forKey: "fullversion")
                    } else if (prodID == "photobackgrounds") {
                        let prefs = NSUserDefaults.standardUserDefaults()
                        prefs.setValue(true, forKey: "photos")
                        
                    }
                   // [self restoreTransaction:transaction];
                default:
                    break;
                }
            }
        }
    }
    func paymentQueueRestoreCompletedTransactionsFinished(queue: SKPaymentQueue) {
        for transaction in queue.transactions {
            let txn: SKPaymentTransaction = transaction as SKPaymentTransaction
            print(txn.payment.productIdentifier)
        }
    }
    @IBAction func restore(sender: AnyObject) {
        let alert = UIAlertView(title: "", message: "Attempting to restore previous purchases.", delegate: self, cancelButtonTitle: "OK")
        alert.show()
       SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
    }
    @IBAction func tapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
   
    @IBAction func buyPhoto(sender: AnyObject) {
        if photoproduct == nil {
            return
        }
        purchaseMyProduct(photoproduct)
    }
    func request(request: SKRequest, didFailWithError error: NSError) {
        if (error.code > 0) {
            let alert = UIAlertView(title: "", message: "Error connecting to AppStore. Please check internet connection and try again.", delegate: self, cancelButtonTitle: "OK")
            alert.show()

        }
          
        
            
        
    }
}

