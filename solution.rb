def set_board
    board = Array.new(8) { Array.new(8) { { nodes: [], position: nil } } }
    board
end

def set_knight(board)
    board.each_with_index do |row, i|
        row.each_with_index do |_col, j|
            board[i][j][:position] = [i, j]
        end
    end
end

def set_nodes(board)
    board.each_with_index do |row, i|
        row.each_with_index do |_col, j|
            board[i][j][:nodes] = get_nodes([i, j])
        end
    end
end

def get_nodes(position)
    moves = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
    nodes = []
    x = position[0]
    y = position[1]
    moves.each do |move|
        new_x = x + move[0]
        new_y = y + move[1]
        if new_x.between?(0, 7) && new_y.between?(0, 7)
            nodes << [new_x, new_y]
        end
    end
    nodes
end

def knight_moves(start, finish)
    board = set_board
    set_knight(board)
    set_nodes(board)
    queue = [start]
    visited = []
    parent = {}
    while !queue.empty?
        current = queue.shift
        visited << current
        if current == finish
            path = []
            while current
                path << current
                current = parent[current]
            end
            return path.reverse
        end
        board[current[0]][current[1]][:nodes].each do |node|
            unless visited.include?(node)
                queue << node
                parent[node] = current unless parent[node]
            end
        end
    end
end
