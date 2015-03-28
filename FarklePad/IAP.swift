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
    let product_value =  "farklepadfull"
    var product: SKProduct!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
        self.fetchAvailableProducts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    func fetchAvailableProducts() {
        let productID:NSSet = NSSet(object: product_value);
        let productsRequest:SKProductsRequest = SKProductsRequest(productIdentifiers: productID);
        productsRequest.delegate = self;
        productsRequest.start();
    }
    
    func productsRequest (request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        let products = response.products
        if products.count != 0
        {
            product = products[0] as SKProduct
            println("Fetched: " + product.productIdentifier)
        }
    }
    
    func canMakePurchases() -> Bool
    {
        return SKPaymentQueue.canMakePayments()
    }
    
    func purchaseMyProduct(product: SKProduct) {
        if (self.canMakePurchases()) {
            println("Purchases are allowed ...")
            var payment: SKPayment = SKPayment(product: product)
            var defaultQueue: SKPaymentQueue  = SKPaymentQueue ()
            defaultQueue.addTransactionObserver(self)
            defaultQueue.addPayment(payment)
        } else {
            println("Purchases are disabled in your device")
        }
    }
    
    
    @IBAction func button1_Click(sender: AnyObject) {
        
     purchaseMyProduct(product)
    }
    func paymentQueue(queue: SKPaymentQueue!, updatedTransactions transactions: [AnyObject]!)    {
        for transaction:AnyObject in transactions {
            if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction{
                switch trans.transactionState {
                case .Purchased:
                    SKPaymentQueue.defaultQueue().finishTransaction(transaction as SKPaymentTransaction)
                    break;
                case .Failed:
                    SKPaymentQueue.defaultQueue().finishTransaction(transaction as SKPaymentTransaction)
                    break;
                case .Restored:
                    SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
                    println("Restored")
                   // [self restoreTransaction:transaction];
                default:
                    break;
                }
            }
        }
    }
    func paymentQueueRestoreCompletedTransactionsFinished(queue: SKPaymentQueue!) {
        for transaction in queue.transactions {
            var txn: SKPaymentTransaction = transaction as SKPaymentTransaction
            println(txn.payment.productIdentifier)
        }
    }
    @IBAction func restore(sender: AnyObject) {
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
       SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
    }
    @IBAction func tapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

