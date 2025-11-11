import time

from gridv1 import Grid
from python import Python, PythonObject


def run_display(
    var grid: Grid,
    pygame: PythonObject,
    window_height: Int = 1000,
    window_width: Int = 1000,
    background_color: String = "black",
    cell_color: String = "green",
    pause: Float64 = 0.1,
) -> None:
    # Initialize pygame modules
    pygame.init()

    # Create a window and set its title
    window = pygame.display.set_mode(Python.tuple(window_height, window_width))
    pygame.display.set_caption("Conway's Game of Life")

    cell_height = window_height / grid.rows
    cell_width = window_width / grid.cols
    border_size = 1
    cell_fill_color = pygame.Color(cell_color)
    background_fill_color = pygame.Color(background_color)

    running = True
    while running:
        # Poll for events
        event = pygame.event.poll()
        if event.type == pygame.QUIT:
            # Quit if the window is closed
            running = False
        elif event.type == pygame.KEYDOWN:
            # Also quit if the user presses <Escape> or 'q'
            if event.key == pygame.K_ESCAPE or event.key == pygame.K_q:
                running = False

        # Clear the window by painting with the background color
        window.fill(background_fill_color)

        # Draw each live cell in the grid
        for row in range(grid.rows):
            for col in range(grid.cols):
                if grid[row, col]:
                    x = col * cell_width + border_size
                    y = row * cell_height + border_size
                    width = cell_width - border_size
                    height = cell_height - border_size
                    pygame.draw.rect(
                        window,
                        cell_fill_color,
                        Python.tuple(x, y, width, height),
                    )

        # Update the display
        pygame.display.flip()

        # Pause to let the user appreciate the scene
        time.sleep(pause)

        # Next generation
        grid = grid.evolve()

    # Shut down pygame cleanly
    pygame.quit()


# An executable Mojo program REQUIRES a no-argument main() function as its entry point
# Running the program automatically invokes the main() function and the program exits
# when the main() function returns
def main():
    pygame = Python.import_module("pygame")
    start = Grid.random(128, 128)
    run_display(start^, pygame)
    # # Demonstrate the Stringable interface implemented by Grid
    # print(String(start))
    # print("Rows: ", start.rows)
    # print("Cols: ", start.cols)
    # # our custom type, Grid, supports indexing with __getitem__ and __setitem__ methods
    # # https://docs.modular.com/mojo/manual/operators/#subscript-and-slicing-dunder-methods
    # print("Cell [1, 1]: ", start[1, 1])
