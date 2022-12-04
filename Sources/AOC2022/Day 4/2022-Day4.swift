//
//  Day4.swift
//  AOC2022
//
//  Created by Dave DeLong on 10/12/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//
import Parsing

class Day4: Day {
  
  let ranges = {
    let range = ParsePrint(.memberwise(ClosedRange.init(uncheckedBounds:))) {
      Int.parser()
      "-".utf8
      Int.parser()
    }
    let twoRanges = ParsePrint {
      range
      ",".utf8
      range
    }
    return Many {
      twoRanges
    } separator: {
      "\n".utf8
    }
  }()

  func run() async throws -> (Int, Int) {
    let ranges = try ranges.parse(input().raw)
    let p1 = ranges.filter(intersect).count
    let p2 = ranges.filter { $0.0.overlaps($0.1) }.count
    return (p1, p2)
  }
}

func intersect(_ x: ClosedRange<Int>, _ y: ClosedRange<Int>) -> Bool {
  return (x.upperBound <= y.upperBound &&
    x.lowerBound >= y.lowerBound) || (x.upperBound >= y.upperBound && x.lowerBound <= y.lowerBound)
}
