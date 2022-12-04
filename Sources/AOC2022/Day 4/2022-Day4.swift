//
//  Day4.swift
//  AOC2022
//
//  Created by Dave DeLong on 10/12/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//
import Parsing

class Day4: Day {
  func parse() throws -> [(ClosedRange<Int>, ClosedRange<Int>)] {
    let range = Parse(ClosedRange.init(uncheckedBounds:)) {
      Int.parser()
      "-".utf8
      Int.parser()
    }
    let twoRanges = Parse {
      range
      ",".utf8
      range
    }
    let ranges = Many {
      twoRanges
    } separator: {
      "\n".utf8
    }
    return try ranges.parse(input().raw)
  }

  func run() async throws -> (Int, Int) {
    let ranges = try parse()
    let p1 = ranges.filter(intersect).count
    let p2 = ranges.filter { $0.0.overlaps($0.1) }.count
    return (p1, p2)
  }
}

func intersect(_ x: ClosedRange<Int>, _ y: ClosedRange<Int>) -> Bool {
  return (x.upperBound <= y.upperBound &&
    x.lowerBound >= y.lowerBound) || (x.upperBound >= y.upperBound && x.lowerBound <= y.lowerBound)
}
