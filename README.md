## Monte Carlo Simulation
This repository is an exploration of the Monte Carlo simulation including a union find algorithm implement in Swift and SwiftUI.

## The Problem
The problem of percolation is dynamic connectivity which has many applications in science, from the way liquids gush up through a porous solid or the way electrons move across a continues metallic surface. It is represented in this project by an N-by-N grid. Each site of the grid can be opened with a tap/mouse-click and when a continous flow of sites exists from the top row to the bottom row, the grid can be said to percolate. This is the point at which electricity can be conducted or liquid can flow through.

##### Here are examples of very basic systems that don't percolate:

![Screen Shot 2021-08-13 at 3 41 47 PM](https://user-images.githubusercontent.com/11002/129410656-0a9e5e7a-b11b-4bf7-94be-63dfe963ec61.png)
![Screen Shot 2021-08-13 at 3 42 08 PM](https://user-images.githubusercontent.com/11002/129410662-16784467-fddd-410e-a1e0-a62f1d86ee57.png)

##### Here is a very basic system that does:

![Screen Shot 2021-08-13 at 3 42 14 PM](https://user-images.githubusercontent.com/11002/129410664-bf508050-5462-4d36-9712-d384f2844a61.png)

##### And here is a much more complex system that percolates:

![Screen Shot 2021-08-13 at 3 44 14 PM](https://user-images.githubusercontent.com/11002/129410819-89db0b73-5aac-48a4-9358-4b97fc2068a8.png)


When you have a large grid with many open sites, you may want to determine whether or not the system percolates. This can be a very daunting tasks if not implemented properly. It can be done easily, yet extremely slowly via quadratic implementations. With a good union-find algorithm, specifically a weighted quick union find with path compression, it can get close to linearithmic: N+M lg N where N is the number of sites and M is the number of operations.

The monte carlo simulation is meant to derive the probability that a system percolates given a number of randomly distributed open sites, and leverages the work of Thomas Bayes' theorem.

## The Implementation
This project is used to demonstrate the utility of a union find algorithm.

This project was inspired by the [percolation project via Princeton's computer science department](https://coursera.cs.princeton.edu/algs4/assignments/percolation/specification.php). If you enjoyed it, or extend it, please let me know.
