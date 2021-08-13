## Monte Carlo Simulation
This repository is an exploration of the Monte Carlo simulation including a union find algorithm implement in Swift and SwiftUI.

## The Problem
The problem of percolation is dynamic connectivity which has many applications in science, from the way liquids gush up through a porous solid or the way electrons move across a continues metallic surface. It is represented in this project by an N-by-N grid. Each site of the grid can be opened with a tap/mouse-click and when a continous flow of sites exists from the top row to the bottom row, the grid can be said to percolate. This is the point at which electricity can be conducted or liquid can flow through.

When you have a large grid with many open sites, you may want to determine whether or not the system percolates. This can be a very daunting tasks if not implemented properly. It can be done easily, yet extremely slowly via quadratic implementations. With a good union-find algorithm, specifically a weighted quick union find with path compression, it can get close to linearithmic: N+M lg N where N is the number of sites and M is the number of operations.

The monte carlo simulation is meant to derive the probability that a system percolates given a number of randomly distributed open sites, and leverages the work of Thomas Bayes' theorem.

## The Implementation
This project is used to demonstrate the utility of a union find algorithm.

This project was inspired by the [percolation project via Princeton's computer science department](https://coursera.cs.princeton.edu/algs4/assignments/percolation/specification.php). If you enjoyed it, or extend it, please let me know.
