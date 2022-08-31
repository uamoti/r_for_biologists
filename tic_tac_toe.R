#!/usr/bin/Rscript

valid_move = function(row, col) {
    on_board = (row %in% 1:3 & col %in% 1:3)
    free_pos = board[row, col] == NA

    return(on_board & free_pos)
}


get_comp_move = function() {
    free_board = which(is.na(board), arr.ind=TRUE)
    x = sample(1:nrow(free_board), 1)

    return(as.vector(free_board[x, ]))
}

get_user_move = function() {
    cat('What row? ')
    row = as.integer(readLines(con=con, n=1))
    cat('What column? ')
    col = as.integer(readLines(con=con, n=1))
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

