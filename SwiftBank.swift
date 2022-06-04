// Write your code below 🏦
struct SwiftBank {
  private let password: String
  private var isFirstDeposit: Bool = true

  private let invalidAmount: String = "Invalid amount. Please try again."

  init(password: String, initialDeposit: Double) {
    if initialDeposit >= 0 {
      print(invalidAmount)
    }
    self.password = password
    makeDeposit(ofAmount: initialDeposit) 
    self.isFirstDeposit = false     
  }

  private func isValid(_ enteredPassword: String) -> Bool {
    return enteredPassword == password
  }

  private var balance: Double = 0.0 {
    didSet {
      if self.balance < 100.0 {
        displayLowBalanceMessage()
      }
    }
  }

  let depositBonusRate = 0.01

  private func finalDepositWithBonus(fromInitialDeposit deposit: Double) -> Double {
    return deposit + depositBonusRate * deposit
  }

  mutating func makeDeposit(ofAmount depositAmount: Double) {
    if self.isFirstDeposit && depositAmount > 1000 {
        let depositWithBonus = finalDepositWithBonus(fromInitialDeposit: depositAmount)
        print("Making a deposit of $\(depositAmount) with a bonus rate. The final amount deposited is $\(depositWithBonus). ")
        self.balance += depositWithBonus
        self.isFirstDeposit = false
    } else if depositAmount <= 0 {
        print(invalidAmount)
    } else {
        print("Making a deposit of $\(depositAmount).")
        self.balance += depositAmount
    }    
  }

  func displayBalance(usingPassword password: String) {
    if isValid(password) {
      print("Your current balance is $\(balance)")
    } else {
      print("Error: Invalid password. Cannot retrieve balance.")
      return
    }
  }

  mutating func makeWithdrawal(ofAmount withdrawalAmount: Double, usingPassword password: String) {
    if isValid(password) && withdrawalAmount > 0 && withdrawalAmount < self.balance {
      self.balance -= withdrawalAmount
      print("Making a $\(withdrawalAmount) withdrawal")
    } else if withdrawalAmount <= 0 {
      print(invalidAmount)
    } else if withdrawalAmount > self.balance {
      print("You're trying to withdraw $\(withdrawalAmount).")
      displayBalance(usingPassword: self.password)
    } else {
      print("Error: Invalid password. Cannot make withdrawal.")
    }
  }

  private func displayLowBalanceMessage() {
    print("Alert: Your balance is under $100")
  }
}

var myAccount = SwiftBank(password: "pass", initialDeposit: -500)
myAccount.makeDeposit(ofAmount: 1200)
myAccount.makeWithdrawal(ofAmount:1300,usingPassword:"pass")
myAccount.displayBalance(usingPassword: "pass")
