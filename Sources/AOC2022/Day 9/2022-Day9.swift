//
//  Day9.swift
//  AOC2022
//
//  Created by Dave DeLong on 10/12/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//
import Collections
import Parsing

class Day9: Day {
  static var rawInput: String? {
    return nil
    """
    addx 15
    addx -11
    addx 6
    addx -3
    addx 5
    addx -1
    addx -8
    addx 13
    addx 4
    noop
    addx -1
    addx 5
    addx -1
    addx 5
    addx -1
    addx 5
    addx -1
    addx 5
    addx -1
    addx -35
    addx 1
    addx 24
    addx -19
    addx 1
    addx 16
    addx -11
    noop
    noop
    addx 21
    addx -15
    noop
    noop
    addx -3
    addx 9
    addx 1
    addx -3
    addx 8
    addx 1
    addx 5
    noop
    noop
    noop
    noop
    noop
    addx -36
    noop
    addx 1
    addx 7
    noop
    noop
    noop
    addx 2
    addx 6
    noop
    noop
    noop
    noop
    noop
    addx 1
    noop
    noop
    addx 7
    addx 1
    noop
    addx -13
    addx 13
    addx 7
    noop
    addx 1
    addx -33
    noop
    noop
    noop
    addx 2
    noop
    noop
    noop
    addx 8
    noop
    addx -1
    addx 2
    addx 1
    noop
    addx 17
    addx -9
    addx 1
    addx 1
    addx -3
    addx 11
    noop
    noop
    addx 1
    noop
    addx 1
    noop
    noop
    addx -13
    addx -19
    addx 1
    addx 3
    addx 26
    addx -30
    addx 12
    addx -1
    addx 3
    addx 1
    noop
    noop
    noop
    addx -9
    addx 18
    addx 1
    addx 2
    noop
    noop
    addx 9
    noop
    noop
    noop
    addx -1
    addx 2
    addx -37
    addx 1
    addx 3
    noop
    addx 15
    addx -21
    addx 22
    addx -6
    addx 1
    noop
    addx 2
    addx 1
    noop
    addx -10
    noop
    noop
    addx 20
    addx 1
    addx 2
    addx 2
    addx -6
    addx -11
    noop
    noop
    noop

    """
  }

  let parser = Many {
    OneOf {
      "noop".map { Int?.none }
      Parse {
        "addx "
        Int.parser().map(Int?.some)
      }
    }
  } separator: {
    "\n"
  }

  let rounds = [20, 60, 100, 140, 180, 220]

  func part1() async throws -> Int {
    let lines = try parser.parse(input().raw)
    var x = 1
    var cycle = 0
    var values: [Int] = []
    var iterator = lines.makeIterator()
    var temp: Int?
    while true {
      cycle += 1
      if rounds.contains(cycle) {
        values.append(x)
      }
      if let _temp = temp {
        x += _temp
        temp = nil
      } else {
        guard let line = iterator.next() else {
          break
        }
        switch line {
          case let .some(value):
            temp = value
          case .none:
            break
        }
      }
    }
    let result = values.enumerated().map { i, value in
      rounds[i] * value
    }
    return result.sum
  }

  func part2() async throws -> String {
    let lines = try parser.parse(input().raw)
    var x = 1
    var xs: [Int] {
      [x - 1, x, x + 1]
    }
    var cycle = 0
    var cx: Int {
      let y = cycle % 40
      return y == 0 ? 40 : y
    }
    var iterator = lines.makeIterator()
    var result = [String]()
    var temp: Int?
    while true {
      cycle += 1
      let s = xs.contains(cx - 1) ? "#" : "."
      result.append(s)
      if let _temp = temp {
        x += _temp
        temp = nil
      } else {
        guard let line = iterator.next() else {
          break
        }
        switch line {
          case let .some(value):
            temp = value
          case .none:
            break
        }
      }
    }
    return [
      result[0...39].joined(),
      result[40...79].joined(),
      result[80...119].joined(),
      result[120...159].joined(),
      result[160...199].joined(),
      result[200...239].joined(),
    ].joined(separator: "\n")

  }

  func run() async throws -> (Int, String) {
    let p1 = try await part1()
    let p2 = try await part2()
    return (p1, p2)
  }
}
