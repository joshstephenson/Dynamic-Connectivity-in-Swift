# Dynamic Connectivity, Percolation, Depth First Search and Shortest Paths
This repository is an exploration of dynamic connectivity, extended from a problem from [Princeton's computer science department](https://coursera.cs.princeton.edu/algs4/assignments/percolation/specification.php). It is implemented in Swift and SwiftUI.


## The Problem - Dynamic Connectivity
Dynamic connectivity has many applications in science and technology. One example is a porous substance that allows liquid to percolate through it. Another is an electrical circuit that allows an electrical current to flow. The basic idea in this experiment is to keep track of how individual sites are connected to each other and whether or not they are part of a continuous network connected to the top.

From there we can ask two separate questions:

1. Is there any route from the top that allows liquid/current to reach the bottom?
2. What is the shortest route from the top that allows liquid/current to reach the bottom?

Answering these two questions requires different ways of thinking about the problem. Each will leverage distinct data structures and employ different algorithms to solve.

![basic-grid](https://user-images.githubusercontent.com/11002/130983602-494849b5-8bff-44f9-aae1-61f6020c7363.gif)

## Part 1: Percolation
The grid above is a simplified system for this problem. Each square represents a site. Closed sites are black and the system begins with all sites closed. Once a site is opened (with a simple click) it turns light gray unless it is connected to the top row, then it is considered full and turns blue.  It's full because if you were to poor fluid in from the top it would reach all sites directly connected to the top. Any opened site that is not connected to the top, remains gray. A system is said to **percolate** when there is any full site on the bottom row. This means that fluid or current can travel all the way from the top to bottom.

As each site is opened we need to check anew, if the system percolates. To determine this is fairly easy if we were to use a brute force algorithm that loops over every site in the grid, but with a larger grid, it would get very costly very quickly. With each increase in grid size the performance degrades quadratically. This is where the [Union Find](https://en.wikipedia.org/wiki/Disjoint-set_data_structure) data structure comes in handy. If we are careful and clever about the way we make changes to the data when each site is opened, then the check for connectivity is remarkably superior.

### The Union
When new connections are made, or in the case of this example project, new sites are opened, we will report these connections to the union-find data structure. This is considered a `union`. When two sites are unioned, what the data structure does is rather simple. If each entity is isolated with no previous connections, then the first will become the parent of the second (think of a simple tree analogy). If each entity does have a parent, then one of the parents becomes a child of the other. In the case of a weighted union find, like this implementation is, the smaller group (by number of total connected entities) becomes a child of the larger one. The crux of this data structure is that _since_ the degrees of separation are not needed, performance can be drastically improved by ignoring the degrees of separation in the data modeling.

### The Find
When we need to determine if an entity is connected to another, we used the `find` query which returns the parent. To determine if two entities are connected, we simply `find` each of them and if the parents are equivalent we know they are connected. When all entities in a system are connected, `find` will return the same identifier for every entity in the system (whichever is the greatest grandparent). So in this implementation, the only thing we need to do when a site is opened is check if the neighboring sites (max of 4) are opened, and if so, `union` with the newly opened site.

### Percolation
This brings us back to percolation. To determine if a system percolates we simply check all the sites in the top row and see if they are connected to any site in the bottom row. To make this faster and more efficient, this implementation adds a virtual top site. Think of this like a single (not shown) site in row 0 that is connected to all the open sites in row 1. When checking if the system percolates, we simply check if  `find` returns the same entity for the virtual top and any site in the bottom row.

Here are some examples of randomly generated percolating systems and their corresponding full sites:
![sample-trials2](https://user-images.githubusercontent.com/11002/130983976-efee39a9-66d6-4236-a7fc-387223289ac2.gif)


## Part 2: Shortest Path
Now let's consider the second question: What is the shortest path from any top site to any bottom site? Answering this question is quite a bit more demanding than percolation. We can't just ignore degrees of separation now, we have to track each possible path from all open sites. In this implementation, we start at the bottom and work up to the top, but there's no reason you couldn't do the inverse.

### Depth First Search
There are two main types of searching in a system like this. You can focus on breadth first or depth first. To focus on breadth first means that for each site with multiple branches (up, down, left & right) you would search each of those adjascent sites before searching their adjascent sites. A depth first search is the opposite and usually favors one direction. In this case, we favor upward movement above lateral or backward movement. If we reach the end of a route and haven't reached the top we backtrack until we get back to a branch and we then try another branch.

You could answer the problem of percolation with a depth first search, but it would be a very inefficient way to simply answer the question of whether or not the system percolates. In this project, I've implemented the union-find data structure/agorithm until the system percolates and once it does, it leverages a depth first search to find the shortest path. Shortest paths are highlighted in green.

Here are some examples of randomly generated percolating systems and their corresponding shortest paths:
![sample-trials](https://user-images.githubusercontent.com/11002/130983801-0e0e443b-87f5-4a70-90a0-3162f0b268ec.gif)



