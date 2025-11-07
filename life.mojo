# An executable Mojo program REQUIRES a no-argument main() function as its entry point
# Running the program automatically invokes the main() function and the program exits
# when the main() function returns
def main():
    name = input("Who are you? ")
    greeting = "Hello, " + name + "!"
    print(greeting)
