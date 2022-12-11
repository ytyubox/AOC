//
//  Test2022.swift
//  AOCTests
//
//  Created by Dave DeLong on 10/12/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//

@testable import AOC2022
import Parsing
import XCTest

@MainActor
class Test2022: XCTestCase {
  func testDay1() async throws {
    let d = Day1()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, 71471)
    XCTAssertEqual(p2, 211189)
  }

  func testDay2() async throws {
    let d = Day2()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, 13809)
    XCTAssertEqual(p2, 12316)
  }

  func testDay3() async throws {
    let d = Day3()
    let (p1, p2) = try await d.run()
    XCTAssertEqual(p1, 7674)
    XCTAssertEqual(p2, 2805)
    XCTAssertEqual([[1], [2], [3]].intersection, [])
    XCTAssertEqual([[1], [1, 2], [1, 3]].intersection, [1])
  }

  func testDay4() async throws {
    let d = Day4()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, 431)
    XCTAssertEqual(p2, 823)
    XCTAssertEqual(intersect(2...4, 6...8), false)
    XCTAssertEqual(intersect(2...3, 4...5), false)
    XCTAssertEqual(intersect(5...7, 7...9), false)
    XCTAssertEqual(intersect(2...8, 3...7), true)
    XCTAssertEqual(intersect(6...6, 4...6), true)
    XCTAssertEqual(intersect(2...6, 4...8), false)
    XCTAssertEqual(intersect(1...2, 3...7), false)
    XCTAssertEqual(intersect(1...2, 2...3), false)
    XCTAssertEqual(intersect(1...1, 1...1), true)
    XCTAssertEqual(intersect(1...2, 2...2), true)
  }

  func testDay5() async throws {
    let d = Day5()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay6() async throws {
    let d = Day6()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay7() async throws {
    let d = Day7()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay8() async throws {
    let d = Day8()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay9() async throws {
    let d = Day9()
    let (p1, p2) = try await d.run()

//    XCTAssertEqual(p1, 13140)
//    XCTAssertEqual(p2,
//                   """
//                   ##..##..##..##..##..##..##..##..##..##..
//                   ###...###...###...###...###...###...###.
//                   ####....####....####....####....####....
//                   #####.....#####.....#####.....#####.....
//                   ######......######......######......####
//                   #######.......#######.......#######.....
//                   """)
    XCTAssertEqual(p1, 14320)
    XCTAssertEqual(p2,
                   """
                   ###...##..###..###..#..#..##..###....##.
                   #..#.#..#.#..#.#..#.#.#..#..#.#..#....#.
                   #..#.#....#..#.###..##...#..#.#..#....#.
                   ###..#....###..#..#.#.#..####.###.....#.
                   #....#..#.#....#..#.#.#..#..#.#....#..#.
                   #.....##..#....###..#..#.#..#.#.....##..
                   """)
  }

  func testDay10() async throws {
    let d = Day10()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay11() async throws {
    let d = Day11()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, 10605)
        XCTAssertEqual(p2, 2713310158)
//    XCTAssertEqual(p1, 108240)
    //    XCTAssertEqual(p2, "")
  }

  func testDay11Parse() throws {
    let raw =
      """
        Operation: new = old * 19
      """
    let parse = Parse {
      "  Operation: new = "
      Prefix { $0 != "\n" }.map(String.init)
    }
    XCTAssertEqual(try parse.parse(raw), "old * 19")
  }

  func testDay12() async throws {
    let d = Day12()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay13() async throws {
    let d = Day13()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay14() async throws {
    let d = Day14()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay15() async throws {
    let d = Day15()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay16() async throws {
    let d = Day16()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay17() async throws {
    let d = Day17()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay18() async throws {
    let d = Day18()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay19() async throws {
    let d = Day19()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay20() async throws {
    let d = Day20()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay21() async throws {
    let d = Day21()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay22() async throws {
    let d = Day22()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay23() async throws {
    let d = Day23()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay24() async throws {
    let d = Day24()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  func testDay25() async throws {
    let d = Day25()
    let (p1, p2) = try await d.run()

    XCTAssertEqual(p1, "")
    XCTAssertEqual(p2, "")
  }

  // MARK: - PoC

  func testIntersection() throws {
    let lines = [
      "NsgwPPDgsPHqsTqqmLbLrDRhmrRVrbVW",
      "lFpGFtfFlvSFplGFzptSGSSlhZbhjhfrmWbhLhmLbCZVZjWr",
      "ccplJQSGcSSpVFvNqqsqPNqPQPTwqd",
    ].map { $0.map { $0 }}
    XCTAssertEqual(
      lines.intersectingElements(),
      ["V", "q", "N", "P", "s", "T", "w"]
    )
    XCTAssertEqual(
      lines.intersection,
      ["V"]
    )
  }
}
