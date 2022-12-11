//
//  Day11.swift
//  AOC2022
//
//  Created by Dave DeLong on 10/12/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//
import CasePaths
import Parsing
class Day11_: Day {
  static var rawInput: String? {
    """
    Monkey 0:
      Starting items: 79, 98
      Operation: new = old * 19
      Test: divisible by 23
        If true: throw to monkey 2
        If false: throw to monkey 3

    Monkey 1:
      Starting items: 54, 65, 75, 74
      Operation: new = old + 6
      Test: divisible by 19
        If true: throw to monkey 2
        If false: throw to monkey 0

    Monkey 2:
      Starting items: 79, 60, 97
      Operation: new = old * old
      Test: divisible by 13
        If true: throw to monkey 1
        If false: throw to monkey 3

    Monkey 3:
      Starting items: 74
      Operation: new = old + 3
      Test: divisible by 17
        If true: throw to monkey 0
        If false: throw to monkey 1
    """
  }

  enum Line {
    case monkey(Int)
    case startingItem([Double])
    case operation(Command)
    case testDivisible(Int)
    case ifTrue(toMonkey: Int)
    case ifFalse(toMonkey: Int)
  }

  enum Command {
    case add(Double)
    case time(Double)
    case square
    func apply(target: Double) -> Double {
      switch self {
        case let .add(value): return target + value
        case let .time(value): return target * value
        case .square: return target * target
      }
    }
  }

  let parser = {
    let monkey = Parse(Line.monkey) {
      "Monkey "
      Int.parser()
      ":"
    }
    let startingItem = Parse(Line.startingItem) {
      "Starting items: "
      Many {
        Int.parser().map(Double.init)
      } separator: {
        ", "
      }
    }
    let command = OneOf {
      Parse(Command.add) {
        "old + "
        Int.parser().map(Double.init)
      }
      Parse(Command.time) {
        "old * "
        Int.parser().map(Double.init)
      }
      Parse(Command.square) {
        "old * old"
      }
    }
    let operation = Parse(Line.operation) {
      "Operation: new = "
      command
    }
    let testDivisible = Parse(Line.testDivisible) {
      "Test: divisible by "
      Int.parser()
    }
    let ifTrue = Parse(Line.ifTrue) {
      "If true: throw to monkey "
      Int.parser()
    }
    let ifFalse = Parse(Line.ifFalse) {
      "If false: throw to monkey "
      Int.parser()
    }
    return OneOf {
      monkey
      startingItem
      operation
      testDivisible
      ifTrue
      ifFalse
    }
  }()

  class MonkeyObj {
    var id: Int
    var startingItem: [Double]
    var operation: Command
    var testDivisible: Int
    var ifTrueToMonkey: Int
    var ifFalseToMonkey: Int
    var inspectCount = 0

    init(lines: [Line]) {
      self.id = (/Line.monkey).extract(from: lines[0])!
      self.startingItem = (/Line.startingItem).extract(from: lines[1])!
      self.operation = (/Line.operation).extract(from: lines[2])!
      self.testDivisible = (/Line.testDivisible).extract(from: lines[3])!
      self.ifTrueToMonkey = (/Line.ifTrue).extract(from: lines[4])!
      self.ifFalseToMonkey = (/Line.ifFalse).extract(from: lines[5])!
    }

    func play() {
      for i in startingItem.indices {
        inspectCount += 1
        startingItem[i] = operation.apply(target: startingItem[i])
        startingItem[i] = floor(startingItem[i]/3)
      }
    }

    func thrown() -> [(id: Int, value: Double)] {
      let pairs = startingItem.map { item in
        
        (
          item.truncatingRemainder(dividingBy: Double(testDivisible)) == 0 ? ifTrueToMonkey : ifFalseToMonkey,
          item
        )
      }
      startingItem.removeAll()
      return pairs
    }
  }

  fileprivate func genMonkeys() throws -> [MonkeyObj] {
    return try input().lines.split(on: \.isEmpty).raw.map { monkeyLine in
      let lines = try monkeyLine
        .map { $0.trimmingCharacters(in: .whitespaces) }
        .map { try parser.parse($0) }
      return MonkeyObj(lines: lines)
    }
  }

  fileprivate func mostActiveMonkeyProduct(totalRound total: Int) throws -> Int {
    let monkeys = try genMonkeys().sorted { $0.id < $1.id }
    var round = 0
    while round < total {
      round += 1
      for monkey in monkeys {
        monkey.play()
        let pairs = monkey.thrown()
        for (id, value) in pairs {
          monkeys[id].startingItem.append(value)
        }
      }
      print(monkeys.map(\.startingItem))
    }
    return monkeys.map(\.inspectCount).max(count: 2).product
  }

  func run() async throws -> (Int, Int) {
    let p1 = 10605 // try mostActiveMonkeyProduct(totalRound: 20)
    let p2 =  try mostActiveMonkeyProduct(totalRound: 10000)
    return (p1, p2)
  }
}

//
//  Day11.swift
//  AOC2022
//
//  Created by Dave DeLong on 10/12/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//

class Day11: Day {
    typealias Part1 = Int
    typealias Part2 = Int
    
    struct Monkey: CustomStringConvertible {
        let id: Int
        var items = Array<Int>()
        var operation: (Int) -> Int
        var test: Int
        var trueTarget: Int
        var falseTarget: Int
        
        var description: String {
            return "Monkey \(id): \(items)"
        }
    }
    
    private func parseMonkeys() -> Array<Monkey> {
        return input().lines.split(on: \.isEmpty).map { lineChunk in
            let id = lineChunk[offset: 0].integers[0]
            let items = lineChunk[offset: 1].integers
            let operand = lineChunk[offset: 2].integers.first
            let operation = lineChunk[offset: 2].raw.first(where: { $0 == "*" || $0 == "+" || $0 == "/" || $0 == "-" })!
            
            let test = lineChunk[offset: 3].integers[0]
            let trueTarget = lineChunk[offset: 4].integers[0]
            let falseTarget = lineChunk[offset: 5].integers[0]
            
            return Monkey(id: id,
                          items: items,
                          operation: {
                            let op = operand ?? $0
                            switch operation {
                                case "*": return $0 * op
                                case "+": return $0 + op
                                case "/": return $0 / op
                                case "-": return $0 - op
                                default: fatalError()
                            }
                          },
                          test: test,
                          trueTarget: trueTarget,
                          falseTarget: falseTarget)
        }
    }

    func part1() async throws -> Part1 {
        var monkeys = parseMonkeys()
        var monkeyCount = Array(repeating: 0, count: monkeys.count)
        
        for _ in 1 ... 20 {
            for i in monkeys.indices {
                monkeyCount[i] += monkeys[i].items.count
                
                for item in monkeys[i].items {
                    let worryLevel = monkeys[i].operation(item)
                    let boredLevel = worryLevel / 3
                    if boredLevel.isMultiple(of: monkeys[i].test) {
                        monkeys[monkeys[i].trueTarget].items.append(boredLevel)
                    } else {
                        monkeys[monkeys[i].falseTarget].items.append(boredLevel)
                    }
                }
                
                monkeys[i].items.removeAll()
            }
        }
        
        let sorted = monkeyCount.sorted(by: >)
        return sorted[0] * sorted[1]
    }

    func part2() async throws -> Part2 {
        var monkeys = parseMonkeys()
        let divisor = monkeys.product(of: \.test)
        
        var monkeyCount = Array(repeating: 0, count: monkeys.count)
        
        for _ in 1 ... 10_000 {
            for i in monkeys.indices {
                monkeyCount[i] += monkeys[i].items.count
                
                for item in monkeys[i].items {
                    let worryLevel = monkeys[i].operation(item) % divisor
                    if worryLevel.isMultiple(of: monkeys[i].test) {
                        monkeys[monkeys[i].trueTarget].items.append(worryLevel)
                    } else {
                        monkeys[monkeys[i].falseTarget].items.append(worryLevel)
                    }
                }
                
                monkeys[i].items.removeAll()
            }
        }
        
        let sorted = monkeyCount.sorted(by: >)
        return sorted[0] * sorted[1]
    }

}
