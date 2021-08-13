//
//  UnionFind.swift
//  Monte Carlo Sim
//
//  Created by Joshua Stephenson on 8/13/21.
//

import Foundation

/** This is a weighted quick union find implementation without path compression
 It was intentionally implemented without generics because integers as indices is faster.
 User is responsible for converting IDs entered into this class into IDs/objects with other classes
 */
class QuickUnionFind {
    private var parent:[Int]
    private var size:[Int]
    public var count:Int
    
    init(_ n:Int) {
        count = n
        parent = [Int](repeating: 0, count: n)
        size = [Int](repeating: 1, count: n)
        for i in 0...n-1 {
            parent[i] = i // each element is its own node
            size[i] = 1
        }
    }

    public func find(_ node:Int) -> Int {
        var p = node
        while (p != parent[p]) {
            p = parent[p]
        }
        return p
    }
    
    public func union(_ first:Int, and second:Int) {
        let rootP = find(first)
        let rootQ = find(second)
        if (rootP == rootQ) { // already connected
            return
        }
        
        // This is the weighted part
        // make smaller root point to larger one
        if (size[rootP] < size[rootQ]) {
            parent[rootP] = rootQ
            size[rootQ] += size[rootP]
        }else {
            parent[rootQ] = rootP
            size[rootP] += size[rootQ]
        }
        count -= 1
    }
}
