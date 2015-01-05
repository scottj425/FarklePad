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
    let product_value =  "CCWXW7S3Z7.com.outofrange.farklepadfree"

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        fetchAvailableProducts()
        // Dispose of any resources that can be recreated.
}
    func fetchAvailableProducts() {
        let productID:NSSet = NSSet(object: self.product_value);
        let productsRequest:SKProductsRequest = SKProductsRequest(productIdentifiers: productID);
        productsRequest.delegate = self;
        productsRequest.start();
    }
    
    func productsRequest (request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        println("here!")
        var count : Int = response.products.count
        if (count>0) {
            var validProducts = response.products
            var validProduct: SKProduct = response.products[0] as SKProduct
            if (validProduct.productIdentifier == self.product_value) {
                println(validProduct.localizedTitle)
                println(validProduct.localizedDescription)
                println(validProduct.price)
            } else {
                println(validProduct.productIdentifier)
            }
        } else {
            println("nothing")
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
        fetchAvailableProducts()
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
                    // case .Restored:
                    //[self restoreTransaction:transaction];
                default:
                    break;
                }
            }
        }
    }
}

