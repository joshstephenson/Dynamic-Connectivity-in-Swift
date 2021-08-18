## Dynamic Connectivity, Percolation and the Monte Carlo Simulation
This repository is an exploration of  dynamic connectivity, percolation and the union find data structure, implemented in Swift and SwiftUI.

![Screen Recording 2021-08-15 at 10 04 06 AM](https://user-images.githubusercontent.com/11002/129481504-0e2d0c19-9908-4665-a752-851d32e51e6c.gif)

## The Problem
This project explores the problem of dynamic connectivity which has many applications in science and technology. The basic idea is to keep track of what entities are connected to other entities ignoring degrees of connectivity. In the case of social networking, you only care _that_ Agustin is in the same network as Aaliyah but you don't need to track the degrees of separation from Agustin to Aaliyah. You might be wondering why that's important. Let's look at another example.

Think of a grid like one in the images on this page which is a simplification of a system that allows fluid to flow through a porous substance or electricity to flow through a circuit. Closed sites (squares) are gray and the system begins with all sites closed. Once a site is opened it turns white unless it is connected to the top row, then it is considered full and turns pink. It's full because if you were to poor fluid in from the top it would reach all sites directly connected to the top. Any opened site that is not connected to the top, remains white. A system is said to **percolate** when there is any full site on the bottom row. This means that fluid or current can travel all the way from the top to bottom.

As each site is opened we need to check if the system percolates. To determine this is fairly easy if we were to use a brute force algorithm, but this could get very costly very quickly. With each increase in grid size the performance degrades quadratically. This is where the [Union Find](https://en.wikipedia.org/wiki/Disjoint-set_data_structure) data structure comes in handy. If we are careful and clever about the way we make changes to the data when each site is opened, then the check for connectivity is remarkably superior.

### The Union
When new connections are made, or in the case of this example project, new sites are opened, we will report these connections to the union-find data structure. This is considered a `union`. When two sites are unioned, what the data structure does is rather simple. If each entity is isolated with no previous connections, then the first will become the parent of the second (think of a simple tree analogy). If each entity does have a parent, then one of the parents becomes a child of the other. In the case of a weighted union find, like this implementation is, the smaller group (by number of total connected entities) becomes a child of the larger one. The crux of this data structure is that _since_ the degrees of separation are not needed, performance can be drastically improved by ignoring the degrees of separation in the data modeling.

### The Find
When you need to determine if an entity is connected to another, we used the `find` query which returns the parent. To determine if two entities are connected, we simply `find` each of them and if the parents are equivalent we know they are connected. When all entities in a system are connected, `find` will return the same identifier for every entity in the system (whichever is the greatest grandparent). So in this implementation, the only thing we need to do when a site is opened is check if the neighboring sites (max of 4) are opened, and if so, `union` with the newly opened site.

### Percolation
This brings us back to percolation. To determine if a system percolates you simply check all the sites in the top row and see if they are connected to any site in the bottom row. To make this faster and more efficient, this implementation adds a virtual top site. Think of this like a single (not shown) site in row 0 that is connected to all the open sites in row 1. There is a corresponding virtual bottom site. When checking if the system percolates, we simply check if  `find` returns the same entity for the virtual top and bottom sites. (Note: this does lead to a problem known as backwash which is not explained or addressed here).

###### Here a very basic system that does not percolate beceause the flow does not reach the bottom
![Screen Shot 2021-08-15 at 10 01 03 AM](https://user-images.githubusercontent.com/11002/129481406-a8798aaa-c734-478d-8da9-f74338fcb4b0.png)


###### Once the bottom site is opened, then it is said to percolate
![Screen Shot 2021-08-15 at 10 01 06 AM](https://user-images.githubusercontent.com/11002/129481417-ae75c24d-d59a-4ef9-b4c8-5d0a3fca0b85.png)


###### And here is a much more complex system that percolates:
![Screen Shot 2021-08-15 at 10 00 45 AM](https://user-images.githubusercontent.com/11002/129481422-5d586c51-8723-4526-9d1f-9a9857578309.png)


## Monte Carlo Simulation
The file `Simulation.swift` runs a monte carlo simulation using the `PercolatingGrid.swift` model. The simulator takes three argumenst:
- trials: this is the number of trials you wish to run. Like any probability, the higher the more precise.
- gridSize: the size of the percolating grid you wish to run the simulation on
- pstar: this is the target probability you would like to have reported

###### As you can see below, the higher the trials, the more narrow the confidence interval
![Screen Shot 2021-08-14 at 12 04 42 PM](https://user-images.githubusercontent.com/11002/129458138-6c32e181-49f2-4061-a611-a0e8d693c958.png)
![Screen Shot 2021-08-14 at 12 04 25 PM](https://user-images.githubusercontent.com/11002/129458139-6f9c637c-7cfa-4cfa-b39f-bcf47e4588f6.png)


###### Notes

* This project was inspired by the [percolation project via Princeton's computer science department](https://coursera.cs.princeton.edu/algs4/assignments/percolation/specification.php). If you enjoyed it, or extend it, please let me know.
