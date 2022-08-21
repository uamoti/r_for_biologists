#!/usr/bin/Rscript

valid_position = function(row, col) {
    return(row %in% 1:3 & col %in% 1:3)
}

open_position = function(row, col) {
    return(board[row, col] == NA)
}

get_comp_move = function() {
    row = sample(1:3, 1)
    col = sample(1:3, 1)

    while(! valid_position(row, col) & open_position(row, col)) {
        row = sample(1:3, 1)
        col = sample(1:3, 1)
    }

    return(row, col)
}

get_user_move = function() {
    cat('What row? ')

    cat('What column? ')
}


if(interactive()) {
    con = stdin()
} else {
    con = 'stdin'
}

cat('X or O? ')
user = toupper(readLines(con=con, n=1))

while(!(user %in% c('X', 'O'))) {
    cat('Please choose a valid character - X or O: ')
    user = toupper(readLines(con=con, n=1))
}

comp = ifelse(user == 'X', 'O', 'X')
board = matrix(nrow=3, ncol=3)

print(board)

