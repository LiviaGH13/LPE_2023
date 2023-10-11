library(httr)

response <- GET("https://jsonplaceholder.typicode.com/posts/1")
content(response, "text")
# Create a 3x3 matrix to represent the game board
board <- matrix(rep(" ", 9), nrow = 3)

# Function to display the game board
display_board <- function(board) {
    cat("\n")
    for (i in 1:nrow(board)) {
        cat(paste0("|", board[i,1], "|", board[i,2], "|", board[i,3], "|\n"))
    }
    cat("\n")
}

# Function to check if a player has won the game
check_win <- function(board, player) {
    # Check rows
    for (i in 1:nrow(board)) {
        if (all(board[i,] == player)) {
            return(TRUE)
        }
    }
    # Check columns
    for (j in 1:ncol(board)) {
        if (all(board[,j] == player)) {
            return(TRUE)
        }
    }
    # Check diagonals
    if (all(diag(board) == player) || all(diag(board[,ncol(board):1])) == player) {
        return(TRUE)
    }
    # No win
    return(FALSE)
}

# Function to check if the game is a tie
check_tie <- function(board) {
    if (!any(board == " ")) {
        return(TRUE)
    }
    return(FALSE)
}

# Function to get the player's move
get_move <- function(board, player) {
    repeat {
        move <- readline(paste0("Player ", player, ", enter your move (row,column): "))
        move <- strsplit(move, ",")[[1]]
        row <- as.integer(move[1])
        col <- as.integer(move[2])
        if (row >= 1 && row <= 3 && col >= 1 && col <= 3 && board[row,col] == " ") {
            return(c(row, col))
        }
        cat("Invalid move. Please try again.\n")
    }
}

# Function to update the game board with the player's move
update_board <- function(board, player, move) {
    board[move[1], move[2]] <- player
    return(board)
}

# Function to switch the player turn
switch_player <- function(player) {
    if (player == "X") {
        return("O")
    } else {
        return("X")
    }
}

# Main function to run the game
play_tictactoe <- function() {
    # Initialize game
    board <- matrix(rep(" ", 9), nrow = 3)
    player <- "X"
    winner <- FALSE
    tie <- FALSE
    
    # Play game
    repeat {
        display_board(board)
        move <- get_move(board, player)
        board <- update_board(board, player, move)
        if (check_win(board, player)) {
            winner <- TRUE
            break
        }
        if (check_tie(board)) {
            tie <- TRUE
            break
        }
        player <- switch_player(player)
    }
    
    # End game
    display_board(board)
    if (winner) {
        cat(paste0("Player ", player, " wins!\n"))
    } else if (tie) {
        cat("Tie game!\n")
    }
}

# Play the game
play_tictactoe()
