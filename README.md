## Dynamic Connectivity, Percolation and the Monte Carlo Simulation
This repository is an exploration of the Monte Carlo simulation including a union find algorithm implemented in Swift and SwiftUI.

## The Problem
This project explores the problem of dynamic connectivity which has many applications in science and technology. The basic idea is keeping track of what entities are connected to other entities disregarding degrees of connectivity. In other words: you only care _that_ Agustin is in the same network as Aaliyah but you don't need to track the route from Agustin to Aaliyah. You might be wondering why that's important. Let's look at another example.

Think of a grid like the ones in the images below. Presume the colored sites (dots) are open and allow fluid or electricity to flow, but the closed sites do not. You need to determine if fluid can flow from the top to the bottom in any way, but just like the social networking case above, you don't care about the specific route. To determine this is fairly easy if you use a brute force algorithm, but as you might imagine it is very inefficient. With each increase in grid size the performance degrades quadratically. This is where the [Union Find](https://en.wikipedia.org/wiki/Disjoint-set_data_structure) data structure comes in handy.

### The Union
When new connections are made, or in the case of this example project, new sites are opened, you report these connections to the union-find data structure. This is a `union`. When two sites are unioned, the data structure doesn't exactly join those two sites. If each entity is isolated with no previous connections, then the first will become the parent of the second. If each entity does have a parent, then the parent of the smallest group becomes a child of the larger group. Think of it like a cafeteria, and when one person switches tables, they actually join the old table with the new table.

### The Find
Then when you need to determine if an entity is connected to another, you used the `find` query which returns the top-most parent. To determine if two entities are connected, you simply `find` each of them and if the identifier (of the parent object) returned from each is equivalent, you know they are connected. When all entities in a system are connected, `find` will returne the same identifier for every entity in the system (whichever is the the greatest grandparent).

### Percolation
This brings us back to percolation. To determine if a system percolates you simply check all the sites in the top row and see if they are connected to any row on the bottom. To make this faster and more efficient, this implementation adds a virtual top site. Think of this like a single (not shown) site in row 0 that is connected to all the sites in row 1. There is a corresponding virtual bottom site. When checking if the system percolates, we simply see if the identifier returned from `find` for the virtual top site and the identifier returned from `find` are the same.

###### Here are examples of very basic systems that don't percolate:

![Screen Shot 2021-08-13 at 3 41 47 PM](https://user-images.githubusercontent.com/11002/129410656-0a9e5e7a-b11b-4bf7-94be-63dfe963ec61.png)
![Screen Shot 2021-08-13 at 3 42 08 PM](https://user-images.githubusercontent.com/11002/129410662-16784467-fddd-410e-a1e0-a62f1d86ee57.png)

###### Here is a very basic system that does percolate:

![Screen Shot 2021-08-13 at 3 42 14 PM](https://user-images.githubusercontent.com/11002/129410664-bf508050-5462-4d36-9712-d384f2844a61.png)

###### And here is a much more complex system that percolates:

![Screen Shot 2021-08-13 at 3 44 14 PM](https://user-images.githubusercontent.com/11002/129410819-89db0b73-5aac-48a4-9358-4b97fc2068a8.png)


## Monte Carlo Simulation
The file `Simulation.swift` runs a monte carlo simulation using the `PercolatingGrid.swift` model. The simulator takes three argumenst:
- trials: this is the number of trials you wish to run. Like any probability, the higher the more precise.
- gridSize: the size of the percolating grid you wish to run the simulation on
- pstar: this is the target probability you would like to have reported

###### As you can see below, the higher the trials, the more narrow the confidence interval
![Screen Shot 2021-08-14 at 12 04 42 PM](https://user-images.githubusercontent.com/11002/129452335-c638b42a-c551-4892-b616-a8684d835a31.png)
![Screen Shot 2021-08-14 at 12 04 25 PM](https://user-images.githubusercontent.com/11002/129452342-4c3a4c65-c4cf-4188-89a9-c9b5ee4b890f.png)


###### Notes

* This project was inspired by the [percolation project via Princeton's computer science department](https://coursera.cs.princeton.edu/algs4/assignments/percolation/specification.php). If you enjoyed it, or extend it, please let me know.
