from gridv1 import Grid


# An executable Mojo program REQUIRES a no-argument main() function as its entry point
# Running the program automatically invokes the main() function and the program exits
# when the main() function returns
def main():
    start = Grid.random(8, 16)
    print(String(start))
